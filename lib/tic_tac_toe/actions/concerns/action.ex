defmodule TicTacToe.Actions.Concerns.Action do
  @moduledoc """
  This module represents a behaviour for all actions.
  """

  @type options :: map

  @doc """
  Triggers the action.
  """
  @callback call(map) :: {:ok, any} | {:error, term}
end
