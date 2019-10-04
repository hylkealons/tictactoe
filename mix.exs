defmodule TicTacToe.MixProject do
  use Mix.Project

  def project do
    [
      app: :tic_tac_toe,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      preferred_cli_env: ["test.all": :test, dialyzer: :dev],
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:sobelow, "~> 0.7", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.1.2", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev], runtime: false}
    ]
  end

  defp aliases do
    [
      "test.all": [
        # Check formatting
        "format --dry-run --check-formatted",
        # Check no compiler errors
        "compile --warnings-as-errors",
        # Check tests succeed
        "test",
        # Check proper code
        "credo",
        # Check no security errors
        "sobelow",
        # Check types
        "dialyzer"
      ]
    ]
  end
end
