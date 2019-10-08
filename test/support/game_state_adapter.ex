defmodule TicTacToe.Support.GameStateAdapter do
  @behaviour TicTacToe.Games.Game.State.Adapter

  alias TicTacToe.Games.Game

  @impl true
  def start_game(_) do
    {:ok, "test-id"}
  end

  @impl true
  def update_game(_) do
    :ok
  end

  @impl true
  def get_game(id) do
    game = Game.new(:o)
    {:ok, %{game | id: id}}
  end
end
