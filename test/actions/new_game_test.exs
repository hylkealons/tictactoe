defmodule TicTacToe.Actions.NewGameTest do
  use ExUnit.Case

  alias TicTacToe.Actions.NewGame

  describe "call/1" do
    test "returns the expected response when called" do
      params = %{starter: :x}
      assert NewGame.call(params) == {:ok, "test-id"}
    end

    test "when a invalid starter is given" do
      params = %{starter: :invalid}
      assert NewGame.call(params) == {:error, :invalid_start_player}
    end
  end
end
