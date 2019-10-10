defmodule TicTacToe do
  use Supervisor

  alias TicTacToe.Games.Game.State.GenServer.Supervisor, as: GameSupervisor

  @spec start_link() :: Supervisor.on_start()
  def start_link() do
    Supervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  # Server
  @impl true
  def init(_) do
    children = [
      %{
        id: GameSupervisor,
        start: {GameSupervisor, :start_link, []},
        type: :supervisor
      }
    ]

    opts = [strategy: :one_for_one]
    Supervisor.init(children, opts)
  end
end
