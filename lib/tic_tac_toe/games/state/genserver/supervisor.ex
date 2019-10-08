defmodule TicTacToe.Games.Game.State.GenServer.Supervisor do
  @moduledoc """
  The Game State Supervisor takes care of active games.
  """
  use DynamicSupervisor

  # Client

  @spec start_link() :: Supervisor.on_start()
  def start_link(_ \\ []) do
    DynamicSupervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  # Server

  @impl true
  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
