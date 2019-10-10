defmodule TicTacToeConsole.ConsoleTest do
  use ExUnit.Case

  alias TicTacToeConsole.Console
  alias TicTacToe.Games.Game.State.Ets

  describe "play/0" do
    setup do
      Ets.init()

      :ets.new(:board, [:duplicate_bag, :private, :named_table])

      :ok
    end

    test "plays a successful game" do
      :ets.insert(:board, {"row", 1})
      :ets.insert(:board, {"column", 1})

      :ets.insert(:board, {"row", 3})
      :ets.insert(:board, {"column", 1})

      :ets.insert(:board, {"row", 1})
      :ets.insert(:board, {"column", 2})

      :ets.insert(:board, {"row", 3})
      :ets.insert(:board, {"column", 2})

      :ets.insert(:board, {"row", 1})
      :ets.insert(:board, {"column", 3})

      Console.play()

      assert_received({:player_won, :x})
    end

    test "when there is an invalid move" do
      :ets.insert(:board, {"row", 1})
      :ets.insert(:board, {"column", 1})

      :ets.insert(:board, {"row", 1})
      :ets.insert(:board, {"column", 1})

      Console.play()

      assert_received({:error, :already_set})
    end
  end
end
