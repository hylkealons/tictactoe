defmodule TicTacToe.Actions.MakeMove do
  @moduledoc """
  This action allows the user to make a move
  """

  @behaviour TicTacToe.Actions.Concerns.Action

  @type params :: %{
          id: any,
          player: :x | :o,
          column: 1 | 2 | 3,
          row: 1 | 2 | 3
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
  defp validate_input(params) do
    cond do
      params[:player] not in [:x, :o] -> {:error, :invalid_player}
      params[:column] not in 1..3 -> {:error, :invalid_column}
      params[:row] not in 1..3 -> {:error, :invalid_row}
      is_nil(params[:id]) -> {:error, :id_not_set}
      true -> :ok
    end
  end
end
