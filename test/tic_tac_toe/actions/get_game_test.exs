defmodule TicTacToe.Actions.GetGameTest do
  use ExUnit.Case

  alias TicTacToe.Actions.GetGame
  alias TicTacToe.Games.Game.State.Ets

  describe "call/1" do
    setup do
      Ets.init()
    end

    test "gets the state" do
      {:ok, game} = Ets.start_game(:x)
      assert GetGame.call(%{id: game.id}) == {:ok, game}
    end

    test "when the state is not found" do
      assert GetGame.call(%{id: :doesntexist}) == {:error, :not_found}
    end
  end
end
