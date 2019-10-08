defmodule TicTacToe.Actions.MakeMoveTest do
  use ExUnit.Case

  alias TicTacToe.Games.Game
  alias TicTacToe.Actions.MakeMove
  alias TicTacToe.Games.Game.State.Ets

  describe "call/1" do
    setup do
      Ets.init()
      {:ok, game} = Ets.start_game(:o)
      valid_params = %{player: :o, column: 3, row: 1, id: game.id}

      %{valid_params: valid_params, game: game}
    end

    test "returns the expected response when called", context do
      expected_game = %Game{
        board: {nil, nil, :o, nil, nil, nil, nil, nil, nil},
        current_player: :x,
        id: context.game.id
      }

      assert MakeMove.call(context.valid_params) == {:ok, expected_game}
    end

    test "when a game is won", context do
      current_board = {:o, :o, nil, nil, nil, nil, nil, nil, nil}
      context.game |> Map.put(:board, current_board) |> Ets.update_game()
      params = %{player: :o, column: 3, row: 1, id: context.game.id}
      assert MakeMove.call(params) == {:winner, {:o, :horizontal, :row1}}
    end

    test "when it's not the players turn", context do
      params = Map.put(context.valid_params, :player, :x)
      assert MakeMove.call(params) == {:error, :turn_other_player}
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
