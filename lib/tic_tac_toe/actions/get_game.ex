defmodule TicTacToe.Actions.GetGame do
  @moduledoc """
  This action returns the current game
  """

  alias TicTacToe.Games.Game

  @behaviour TicTacToe.Actions.Concerns.Action

  @adapter Application.get_env(:tic_tac_toe, Game)[:adapter] || raise("Game adapter must be set")

  @type params :: %{id: any}

  @impl true
  @spec call(params) :: {:ok, Game.t()} | {:error, term}
  def call(params) do
    case validate_input(params) do
      :ok -> @adapter.get_game(params.id)
      {:error, reason} -> {:error, reason}
    end
  end

  @spec validate_input(params) :: :ok | {:error, term}
  defp validate_input(%{id: _}), do: :ok
  defp validate_input(_), do: {:error, :id_missing}
end
