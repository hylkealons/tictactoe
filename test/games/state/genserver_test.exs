defmodule TicTacToe.Games.Game.State.GenServerTest do
  use ExUnit.Case

  alias TicTacToe.Games.Game.State.GenServer, as: GameServer
  alias TicTacToe.Games.Game.State.GenServer.Supervisor, as: GameSupervisor

  describe "start_link/1" do
    test "starts the genserver" do
      assert {:ok, pid} = start_supervised(GameServer)
      assert is_pid(pid)
    end
  end

  describe "start_game/1" do
    setup do
      {:ok, pid} = GameSupervisor.start_link()
      %{supervisor: pid}
    end

    test "starts a new game in the supervisor", context do
      assert DynamicSupervisor.which_children(context.supervisor) == []
      {:ok, pid} = GameServer.start_game(:x)
      expected = [{:undefined, pid, :worker, [GameServer]}]
      assert DynamicSupervisor.which_children(context.supervisor) == expected
    end

    test "can start two games", context do
      assert DynamicSupervisor.which_children(context.supervisor) == []
      {:ok, pid1} = GameServer.start_game(:x)
      {:ok, pid2} = GameServer.start_game(:o)

      expected = [
        {:undefined, pid1, :worker, [GameServer]},
        {:undefined, pid2, :worker, [GameServer]}
      ]

      assert DynamicSupervisor.which_children(context.supervisor) == expected
    end
  end
end
