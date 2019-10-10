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
      assert {ok, id} = Ets.start_game(:x)
      assert is_binary(id)
    end
  end

  describe "update_game/1" do
    setup do
      Ets.init()
      :ok
    end

    test "updates a game and returns it" do
      {:ok, game_id} = Ets.start_game(:x)
      {:ok, game} = Ets.get_game(game_id)
      game = Map.put(game, :current_player, :o)
      assert {:ok, %Game{current_player: :o}} = Ets.update_game(game)
    end
  end

  describe "get_game/1" do
    setup do
      Ets.init()
      :ok
    end

    test "gets a game by the identifier" do
      {:ok, id} = Ets.start_game(:x)

      assert {:ok, %Game{id: ^id}} = Ets.get_game(id)
    end

    test "when a game does not exist" do
      assert Ets.get_game("missing") == {:error, :not_found}
    end
  end
end
