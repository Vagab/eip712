defmodule Eip712.MixProject do
  use Mix.Project

  def project do
    [
      app: :eip712,
      version: "0.2.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    "Library for encoding and signing EIP-712 typed data in elixir."
  end

  defp package do
    [
      name: "eip712",
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/stocks29/eip712"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_keccak, "~> 0.7.3"},
      {:ex_abi, "~> 0.6.4"},
      {:curvy, "~> 0.3.1"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
