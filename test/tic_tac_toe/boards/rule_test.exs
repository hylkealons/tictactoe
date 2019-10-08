defmodule TicTacToe.Boards.RuleTest do
  use ExUnit.Case

  alias TicTacToe.Boards.Rule
  alias TicTacToe.Boards.Board

  @empty_board Board.new()

  describe "board_winner/1" do
    test "when there is a known win" do
      win_combinations = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [2, 4, 6],
        [0, 4, 8]
      ]

      Enum.each(win_combinations, fn win_combination ->
        win_board = Enum.reduce(win_combination, @empty_board, &put_elem(&2, &1, :x))
        assert {:winner, {:x, _, _}} = Rule.board_winner(win_board)
      end)
    end

    test "returns the right win type and reason" do
      win_board = @empty_board |> put_elem(2, :x) |> put_elem(4, :x) |> put_elem(6, :x)

      assert Rule.board_winner(win_board) == {:winner, {:x, :diagonal, :rightleft}}
    end

    test "when there is no win" do
      board = @empty_board |> put_elem(2, :x) |> put_elem(4, :o) |> put_elem(6, :x)

      assert Rule.board_winner(board) == :no_winner
    end

    test "with an empty board" do
      assert Rule.board_winner(@empty_board) == :no_winner
    end
  end
end
