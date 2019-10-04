defmodule TicTacToe.Actions.MakeMoveTest do
  use ExUnit.Case

  alias TicTacToe.Actions.MakeMove

  describe "call/1" do
    setup do
      valid_params = %{player: :x, column: 3, row: 1, id: "id"}

      %{valid_params: valid_params}
    end

    test "returns the expected response when called", context do
      assert MakeMove.call(context.valid_params) == {:error, :not_implemented}
    end

    test "when a invalid player is given", context do
      params = Map.put(context.valid_params, :player, :invalid)
      assert MakeMove.call(params) == {:error, :invalid_player}
    end

    test "when id is missing", context do
      params = Map.delete(context.valid_params, :id)
      assert MakeMove.call(params) == {:error, :id_not_set}
    end

    test "when column is invalid", context do
      params = Map.put(context.valid_params, :column, 5)
      assert MakeMove.call(params) == {:error, :invalid_column}
    end

    test "when row is invalid", context do
      params = Map.put(context.valid_params, :row, 5)
      assert MakeMove.call(params) == {:error, :invalid_row}
    end
  end
end
