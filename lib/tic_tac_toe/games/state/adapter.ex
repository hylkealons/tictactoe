defmodule TicTacToe.Games.Game.State.Adapter do
  @moduledoc """
  The state is stored in an adapter. The adapter has to implement this behaviour.
  """

  alias TicTacToe.Players.Player
  alias TicTacToe.Games.Game

  @doc """
  When a new game is started
  """
  @callback start_game(Player.t()) :: {:ok, Game.id()} | {:error, term}
  @callback update_game(Game.t()) :: {:ok, Game.t()} | {:error, term}
  @callback get_game(Game.id()) :: {:ok, Game.t()} | {:error, term}
end
