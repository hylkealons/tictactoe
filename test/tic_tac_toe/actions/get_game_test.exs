defmodule TicTacToe.Actions.GetGameTest do
  use ExUnit.Case

  alias TicTacToe.Games.Game
  alias TicTacToe.Actions.GetGame
  alias TicTacToe.Games.Game.State.Ets

  describe "call/1" do
    setup do
      Ets.init()
    end

    test "gets the state" do
      {:ok, game_id} = Ets.start_game(:x)
      assert {:ok, %Game{}} = GetGame.call(%{id: game_id})
    end

    test "when the state is not found" do
      assert GetGame.call(%{id: :doesntexist}) == {:error, :not_found}
    end
  end
end
