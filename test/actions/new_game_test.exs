defmodule TicTacToe.Actions.NewGameTest do
  use ExUnit.Case

  alias TicTacToe.Games.Game.State.Ets
  alias TicTacToe.Actions.NewGame

  describe "call/1" do
    setup do
      Ets.init()
      :ok
    end

    test "returns the expected response when called" do
      params = %{starter: :x}
      assert {:ok, _} = NewGame.call(params)
    end

    test "when a invalid starter is given" do
      params = %{starter: :invalid}
      assert NewGame.call(params) == {:error, :invalid_start_player}
    end
  end
end
