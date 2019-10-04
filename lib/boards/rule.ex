defmodule TicTacToe.Boards.Rule do
  @moduledoc """
  The Rule defines based on a board whether there is a win on the board.
  """

  alias TicTacToe.Boards.Board
  alias TicTacToe.Players.Player

  @typep win_type :: :horizontal | :diagonal | :vertical
  @typep win_reason ::
           :row1 | :row2 | :row3 | :leftright | :rightleft | :column1 | :column2 | :column3

  @winning_rules [
    {[0, 1, 2], :horizontal, :row1},
    {[3, 4, 5], :horizontal, :row2},
    {[6, 7, 8], :horizontal, :row3},
    {[0, 3, 6], :vertical, :column1},
    {[1, 4, 7], :vertical, :column2},
    {[2, 5, 8], :vertical, :column3},
    {[0, 4, 8], :diagonal, :leftright},
    {[2, 4, 6], :diagonal, :rightleft}
  ]

  @doc """
  Returns the winner and how the game is won. Returns no_winner if the board is there is no outcome yet.
  """
  @spec board_winner(Board.t()) :: {:winner, {Player.t(), win_type, win_reason}} | :no_winner
  def board_winner(board) do
    Enum.find_value(@winning_rules, :no_winner, fn {winning_rule, win_type, win_reason} ->
      case Enum.map(winning_rule, &elem(board, &1)) do
        [player, player, player] when player != nil -> {:winner, {player, win_type, win_reason}}
        _ -> nil
      end
    end)
  end
end
