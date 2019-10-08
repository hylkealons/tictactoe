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

  describe "get_game/1" do
    setup do
      {:ok, _} = GameSupervisor.start_link()
      {:ok, game_pid} = GameServer.start_game(:o)
      %{game_pid: game_pid}
    end

    test "when the game exists", context do
      expected_game = %TicTacToe.Games.Game{
        board: {nil, nil, nil, nil, nil, nil, nil, nil, nil},
        current_player: :o,
        id: context.game_pid
      }

      assert GameServer.get_game(context.game_pid) == {:ok, expected_game}
    end

    test "when the game does not exist" do
      assert GameServer.get_game(nil) == {:error, :not_found}
    end
  end

  describe "update_game/1" do
    setup do
      {:ok, supervisor_pid} = GameSupervisor.start_link()
      {:ok, game_pid} = GameServer.start_game(:x)
      %{supervisor: supervisor_pid, game_pid: game_pid}
    end

    test "updates the game in the state", context do
      {:ok, game} = GameServer.get_game(context.game_pid)
      game = Map.put(game, :player, :o)
      GameServer.update_game(game)

      {:ok, game} = GameServer.get_game(context.game_pid)
      assert game.player == :o
    end

    test "when the game does not exist", context do
      {:ok, game} = GameServer.get_game(context.game_pid)
      DynamicSupervisor.terminate_child(context.supervisor, context.game_pid)
      assert GameServer.update_game(game) == {:error, :not_found}
    end
  end
end
