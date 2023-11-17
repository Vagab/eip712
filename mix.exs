defmodule Eip712.MixProject do
  use Mix.Project

  def project do
    [
      app: :eip712,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_keccak, "~> 0.7.3"},
      {:ex_abi, "~> 0.6.4"},
      {:curvy, "~> 0.3.1"}
    ]
  end
end
