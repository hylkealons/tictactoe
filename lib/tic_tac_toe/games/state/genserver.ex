defmodule TicTacToe.Games.Game.State.GenServer do
  use GenServer

  alias TicTacToe.Games.Game
  alias TicTacToe.Players.Player
  alias TicTacToe.Games.Game.State.GenServer.Supervisor, as: GameServerSupervisor

  @behaviour TicTacToe.Games.Game.State.Adapter

  # Client

  @spec start_link(Game.t()) :: GenServer.on_start()
  def start_link(game) do
    GenServer.start_link(__MODULE__, [game])
  end

  @impl true
  @spec start_game(Player.t()) :: {:ok, pid}
  def start_game(start_player) do
    game = Game.new(start_player)
    child_spec = {__MODULE__, game}
    {:ok, pid} = DynamicSupervisor.start_child(GameServerSupervisor, child_spec)
    GenServer.call(pid, {:update, %{game | id: pid}})
    {:ok, pid}
  end

  @impl true
  @spec update_game(Game.t()) :: {:ok, Game.t()}
  def update_game(game) do
    if game_exists?(game.id) do
      game = GenServer.call(game.id, {:update, game})
      {:ok, game}
    else
      {:error, :not_found}
    end
  end

  @impl true
  @spec get_game(Game.id()) :: {:ok, Game.t()} | {:error, term}
  def get_game(game_pid) do
    if game_exists?(game_pid) do
      {:ok, GenServer.call(game_pid, :get)}
    else
      {:error, :not_found}
    end
  end

  @spec game_exists?(Game.id()) :: boolean
  defp game_exists?(game_pid) do
    if is_pid(game_pid) && Process.alive?(game_pid) do
      true
    else
      false
    end
  end

  # Server

  @impl true
  @spec init(Game.t()) :: {:ok, Game.t()}
  def init(game), do: {:ok, game}

  @impl true
  def handle_call({:update, game}, _, _), do: {:reply, game, game}

  @impl true
  def handle_call(:get, _, game), do: {:reply, game, game}
end
