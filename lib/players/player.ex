defmodule TicTacToe.Players.Player do
  @moduledoc """
  The player of the tic tac toe game
  """

  @type t :: :x | :o

  @doc """
  Returns the next players turn
  """
  @spec next(t) :: t
  def next(:x), do: :o
  def next(:o), do: :x
end
