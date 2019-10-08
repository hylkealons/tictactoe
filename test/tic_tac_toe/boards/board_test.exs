defmodule TicTacToe.Boards.BoardTest do
  use ExUnit.Case

  alias TicTacToe.Boards.Board

  @empty_board {nil, nil, nil, nil, nil, nil, nil, nil, nil}

  describe "new/0" do
    test "creates a new board" do
      assert Board.new() == @empty_board
    end
  end

  describe "set/4" do
    test "sets the values on the board" do
      {:ok, board} = Board.set(@empty_board, :x, 2, 2)
      {:ok, board} = Board.set(board, :x, 3, 2)
      assert elem(board, 4) == :x
      assert elem(board, 7) == :x
    end

    test "cannot set the value twice" do
      {:ok, board} = Board.set(@empty_board, :x, 2, 2)
      assert Board.set(board, :x, 2, 2) == {:error, :already_set}
    end

    test "cannot set out of bounds" do
      valid_value = 2

      Enum.each([0, -1, 4], fn invalid_value ->
        assert Board.set(@empty_board, :x, invalid_value, valid_value) == {:error, :out_of_bounds}
        assert Board.set(@empty_board, :x, valid_value, invalid_value) == {:error, :out_of_bounds}
      end)
    end
  end
end
