defmodule TicTacToe.MixProject do
  use Mix.Project

  def project do
    [
      app: :tic_tac_toe,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      preferred_cli_env: ["test.all": :test, dialyzer: :dev],
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      mod: {TicTacToe, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:sobelow, "~> 0.7", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.1.2", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev], runtime: false},
      {:uuid, "~> 1.1"}
    ]
  end

  defp aliases do
    [
      test: "test --no-start",
      "test.all": [
        # Check formatting
        "format --dry-run --check-formatted",
        # Check no compiler errors
        "compile --warnings-as-errors",
        # Check tests succeed
        "test --no-start",
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
