defmodule TicTacToe.Games.Game.State.EtsTest do
  use ExUnit.Case

  alias TicTacToe.Games.Game
  alias TicTacToe.Games.Game.State.Ets

  describe "init/0" do
    test "initializes the table and returns correct response" do
      assert Ets.init() == :ok
    end
  end

  describe "start_game/1" do
    setup do
      Ets.init()
      :ok
    end

    test "starts a game and returns it" do
      assert {ok, %Game{}} = Ets.start_game(:x)
    end
  end

  describe "update_game/1" do
    setup do
      Ets.init()
      :ok
    end

    test "updates a game and returns it" do
      {:ok, game} = Ets.start_game(:x)
      game = Map.put(game, :current_player, :o)
      assert Ets.update_game(game) == {:ok, game}
    end
  end

  describe "get_game/1" do
    setup do
      Ets.init()
      :ok
    end

    test "gets a game by the identifier" do
      {:ok, %Game{id: id} = game} = Ets.start_game(:x)

      assert Ets.get_game(id) == {:ok, game}
    end

    test "when a game does not exist" do
      assert Ets.get_game("missing") == {:error, :not_found}
    end
  end
end
