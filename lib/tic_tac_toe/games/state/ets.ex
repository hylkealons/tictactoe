defmodule TicTacToe.Games.Game.State.Ets do
  @behaviour TicTacToe.Games.Game.State.Adapter

  alias TicTacToe.Games.Game

  import UUID

  def init() do
    :ets.new(:games, [:set, :private, :named_table])
    :ok
  end

  @impl true
  def start_game(player) do
    game = Game.new(player, %{id: uuid4()})
    :ets.insert(:games, {game.id, game})
    {:ok, game.id}
  end

  @impl true
  def update_game(game) do
    :ets.insert(:games, {game.id, game})
    {:ok, game}
  end

  @impl true
  def get_game(id) do
    case :ets.lookup(:games, id) do
      [{_, game}] -> {:ok, game}
      _ -> {:error, :not_found}
    end
  end
end
