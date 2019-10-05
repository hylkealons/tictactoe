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
    GenServer.cast(pid, {:update, %{game | id: pid}})
    {:ok, pid}
  end

  # Server

  @impl true
  @spec init(Game.t()) :: {:ok, Game.t()}
  def init(game), do: {:ok, game}

  @impl true
  @spec handle_cast({:update, Game.t()}, Game.t()) :: {:noreply, Game.t()}
  def handle_cast({:update, game}, _), do: {:noreply, game}
end
