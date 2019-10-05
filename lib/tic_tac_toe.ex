defmodule TicTacToe do
  use Application

  alias TicTacToe.Games.Game.State.GenServer.Supervisor, as: GameSupervisor

  @impl true
  @spec start(any, any) :: {:error, any} | {:ok, pid()} | {:ok, pid(), any}
  def start(_type, _args) do
    children = [
      %{
        id: GameSupervisor,
        start: {GameSupervisor, :start_link, []},
        type: :supervisor
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TicTacToe.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
