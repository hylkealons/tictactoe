defmodule TicTacToe.Games.Game.State.Adapter do
  @moduledoc """
  The state is stored in an adapter. The adapter has to implement this behaviour.
  """

  alias TicTacToe.Players.Player

  @doc """
  When a new game is started
  """
  @callback start_game(Player.t()) :: {:ok, id :: any} | {:error, term}
end
