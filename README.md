# EIP712

![EIP712](./eip-712-logo.jpeg)

---

Library for encoding EIP-712 typed data in elixir.

See the [documentation](https://hexdocs.pm/eip712) for more information.

## Installation

The package can be installed by adding `eip712` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:eip712, "~> 0.1.0"}
  ]
end
```

## Usage

```elixir
priv_key = EIP712.Util.decode_hex!("0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80")

%EIP712.Typed{
  domain: %EIP712.Typed.Domain{
    chain_id: 1,
    name: "Test",
    verifying_contract: EIP712.Util.decode_hex!("0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC"),
    version: "1"
  },
  types: %{
    "Test" => %EIP712.Typed.Type{fields: [{"items", {:array, :string}}]}
  },
  value: %{
    "items" => ["item1", "item2"]
  }
}
|> EIP712.sign!(priv_key, hex?: true)
# => "0x97ce47cfb1497f72019606ba462c3ab4e3552c4225f3b7b75ca42c5787a19b7c29d53b9fe402102a82ea782e806224f819b326b74f98049fe59486640d6fa2911c"
```

## License

MIT

## Credits

This library consists of the EIP-712 pieces extracted from [Signet](https://github.com/hayesgm/signet/).
Thanks to Geoff Hayes for the original implementation.

