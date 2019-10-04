defmodule TicTacToe.Actions.NewGame do
  @moduledoc """
  This action starts a new game. It returns the identifier of the game, which is needed to do an
  action on this board.
  """

  @behaviour TicTacToe.Actions.Concerns.Action

  @type params :: %{
          starter: :x | :o
        }

  @impl true
  @spec call(params) :: {:error, term}
  def call(params) do
    case validate_input(params) do
      :ok -> {:error, :not_implemented}
      {:error, reason} -> {:error, reason}
    end
  end

  @spec validate_input(params) :: :ok | {:error, term}
  defp validate_input(%{starter: starter}) when starter in [:x, :o], do: :ok
  defp validate_input(_), do: {:error, :invalid_start_player}
end
