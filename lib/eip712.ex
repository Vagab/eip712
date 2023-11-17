defmodule EIP712 do
  @moduledoc """
  Documentation for `EIP712`.
  """

  import EIP712.Util, only: [encode_bytes: 2]

  @doc """
  Sign a message.

      iex> %EIP712.Typed{
      ...>   domain: %EIP712.Typed.Domain{
      ...>     chain_id: 1,
      ...>     name: "Test",
      ...>     verifying_contract: EIP712.Util.decode_hex!("0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC"),
      ...>     version: "1"
      ...>   },
      ...>   types: %{
      ...>     "Test" => %EIP712.Typed.Type{fields: [{"items", {:array, :string}}]}
      ...>   },
      ...>   value: %{
      ...>     "items" => ["item1", "item2"]
      ...>   }
      ...> }
      ...> |> EIP712.sign!(
      ...>   EIP712.Util.decode_hex!("0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"),
      ...>   hex?: true
      ...> )
      "0x97ce47cfb1497f72019606ba462c3ab4e3552c4225f3b7b75ca42c5787a19b7c29d53b9fe402102a82ea782e806224f819b326b74f98049fe59486640d6fa2911c"
  """
  @spec sign!(EIP712.Typed.t() | String.t(), binary(), Keyword.t()) :: binary()
  def sign!(message, priv_key, opts \\ []) do
    {:ok, sig} = sign(message, priv_key, opts)
    sig
  end

  def sign(message, priv_key, opts \\ [])

  @spec sign(EIP712.Typed.t(), binary(), Keyword.t()) :: {:ok, binary()} | {:error, String.t()}
  def sign(%EIP712.Typed{} = typed, priv_key, opts) do
    typed
    |> EIP712.Typed.encode()
    |> EIP712.Hash.keccak()
    |> sign(priv_key, opts)
  end

  @spec sign(String.t(), binary(), Keyword.t()) :: {:ok, binary()} | {:error, String.t()}
  def sign(message, priv_key, opts) do
    chain_id = Keyword.get(opts, :chain_id, 0)
    hex? = Keyword.get(opts, :hex?, false)

    with key <- Curvy.Key.from_privkey(priv_key),
         sig_bin <- Curvy.sign(message, key, hash: :keccak, compact: true),
         %Curvy.Signature{crv: :secp256k1, r: r, recid: recid, s: s} <-
           Curvy.Signature.parse(sig_bin) do
      # EIP-155
      v = if chain_id == 0, do: 27 + recid, else: chain_id * 2 + 35 + recid

      sig_bin = encode_bytes(r, 32) <> encode_bytes(s, 32) <> encode_bytes(v, 1)

      if hex? do
        {:ok, EIP712.Util.encode_hex(sig_bin)}
      else
        {:ok, sig_bin}
      end
    end
  end
end
