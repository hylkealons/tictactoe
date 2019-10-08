defmodule TicTacToe.Players.PlayerTest do
  use ExUnit.Case

  alias TicTacToe.Players.Player

  describe "next/1" do
    test "switches player succesfully" do
      current_player = :x
      assert Player.next(current_player) == :o
      current_player = :o
      assert Player.next(current_player) == :x
    end
  end
end
