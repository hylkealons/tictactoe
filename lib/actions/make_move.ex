defmodule TicTacToe.Actions.MakeMove do
  @moduledoc """
  This action allows the user to make a move
  """

  @behaviour TicTacToe.Actions.Concerns.Action

  alias TicTacToe.Games.Game
  alias TicTacToe.Boards.Rule
  alias TicTacToe.Boards.Board
  alias TicTacToe.Players.Player

  @adapter Application.get_env(:tic_tac_toe, Game)[:adapter] || raise("Game adapter must be set")

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
      :ok -> move(params.id, params.player, params.row, params.column)
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

  @spec move(Game.id(), Player.t(), Board.row(), Board.column()) :: {:ok, Game.t()}
  defp move(game_id, player, row, column) do
    with {:ok, game} <- @adapter.get_game(game_id),
         {:is_turn_player, true} <- {:is_turn_player, player == game.current_player},
         {:ok, board} <- Board.set(game.board, player, row, column),
         :no_winner <- Rule.board_winner(board) do
      updated_game =
        game
        |> Map.put(:board, board)
        |> Map.put(:current_player, Player.next(game.current_player))

      @adapter.update_game(updated_game)

      {:ok, updated_game}
    else
      {:is_turn_player, false} -> {:error, :turn_other_player}
      error -> error
    end
  end
end
