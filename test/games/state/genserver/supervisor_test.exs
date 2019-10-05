defmodule TicTacToe.Games.Game.State.GenServer.SupervisorTest do
  use ExUnit.Case

  alias TicTacToe.Games.Game.State.GenServer.Supervisor, as: GameSupervisor

  describe "start_link/0" do
    test "starts the game supervisor" do
      {:ok, pid} = GameSupervisor.start_link()
      assert is_pid(pid)
    end

    test "is findable by it's module as name" do
      GameSupervisor.start_link()
      assert GameSupervisor |> Process.whereis() |> is_pid()
    end
  end
end
