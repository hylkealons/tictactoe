defmodule TicTacToe.Games.GameTest do
  use ExUnit.Case

  alias TicTacToe.Games.Game

  describe "new/0" do
    test "creates a new game" do
      expected = %Game{
        board: {nil, nil, nil, nil, nil, nil, nil, nil, nil},
        current_player: :x,
        id: nil
      }

      assert Game.new(:x) == expected
    end
  end
end
