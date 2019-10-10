defmodule TicTacToe.Application do
  use Application

  @impl true
  @spec start(any, any) :: {:error, any} | {:ok, pid()} | {:ok, pid(), any}
  def start(_type, _args) do
    children = [
      %{
        id: TicTacToe,
        start: {TicTacToe, :start_link, []},
        type: :supervisor
      },
      %{
        id: TicTacToeConsole,
        start: {TicTacToeConsole, :play, []},
        type: :worker
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end
end
