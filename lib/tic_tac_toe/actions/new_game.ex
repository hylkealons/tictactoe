defmodule TicTacToe.Actions.NewGame do
  @moduledoc """
  This action starts a new game. It returns the identifier of the game, which is needed to do an
  action on this board.
  """

  alias TicTacToe.Games.Game

  @behaviour TicTacToe.Actions.Concerns.Action

  @type params :: %{
          starter: :x | :o
        }

  @adapter Application.get_env(:tic_tac_toe, Game)[:adapter] || raise("Game adapter must be set")

  @doc """
  Creates the new game and returns the identifier
  """
  @impl true
  @spec call(params) :: {:ok, id :: any} | {:error, term}
  def call(params) do
    case validate_input(params) do
      :ok -> create_game(params)
      {:error, reason} -> {:error, reason}
    end
  end

  @spec create_game(params) :: {:ok, id :: any}
  defp create_game(params) do
    @adapter.start_game(params.starter)
  end

  @spec validate_input(params) :: :ok | {:error, term}
  defp validate_input(%{starter: starter}) when starter in [:x, :o], do: :ok
  defp validate_input(_), do: {:error, :invalid_start_player}
end
