defmodule TicTacToe.Games.Game do
  @moduledoc """
  The game constains the state of the game
  """

  alias __MODULE__
  alias TicTacToe.Players.Player
  alias TicTacToe.Boards.Board

  @type id :: any
  @type t :: %Game{
          id: id,
          board: Board.t(),
          current_player: Player.t()
        }

  defstruct ~w(id board current_player)a

  @spec new(Player.t(), map) :: t
  def new(start_player, opts \\ %{}) do
    %Game{
      id: Map.get(opts, :id),
      board: Map.get(opts, :board) || Board.new(),
      current_player: Map.get(opts, :current_player) || start_player
    }
  end
end
