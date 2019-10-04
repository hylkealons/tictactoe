defmodule TicTacToe.Support.GameStateAdapter do
  @behaviour TicTacToe.Games.Game.State.Adapter

  @impl true
  def start_game(_) do
    {:ok, "test-id"}
  end
end
