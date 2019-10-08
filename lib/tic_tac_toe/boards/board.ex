defmodule TicTacToe.Boards.Board do
  @moduledoc """
  The `Board` represents the playing board.
  """

  alias TicTacToe.Players.Player

  @type column :: Player.t() | nil
  @type row :: pos_integer
  @type t :: {column, column, column, column, column, column, column, column, column}

  @doc """
  Returns a new board. The board is represented is flattened and returned as a tuple.
  """
  @spec new() :: t
  def new(), do: Tuple.duplicate(nil, 9)

  @spec set(t, Player.t(), row, column) :: {:ok, t} | {:error, term}
  def set(board, player, row, column) when row in [1, 2, 3] and column in [1, 2, 3] do
    position = (row - 1) * 3 + (column - 1)

    case elem(board, position) do
      nil -> {:ok, put_elem(board, position, player)}
      _ -> {:error, :already_set}
    end
  end

  def set(_, _, _, _), do: {:error, :out_of_bounds}
end
