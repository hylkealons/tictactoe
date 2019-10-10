defmodule TicTacToeConsole do

  alias TicTacToe.Actions.{GetGame, MakeMove}
  alias TicTacToe.Games.Game

  @io_module Application.get_env(:tic_tac_toe, TicTacToeConsole)[:io_module] ||
               raise("io module not set")

  @system_module Application.get_env(:tic_tac_toe, TicTacToeConsole)[:system_module] ||
                   raise("system module not set")

  @spec play :: no_return()
  def play do
    {:ok, game_id} = start_game()
    {:ok, game} = GetGame.call(%{id: game_id})
    move_until_win(game)
    play_again()
  rescue
    e ->
      @io_module.puts("An error occured. #{inspect(e)}")
      play_again()
  end

  @spec play_again() :: no_return
  defp play_again do
    play_again = "Do you want to play again? (y/n): " |> @io_module.gets() |> String.trim()

    case play_again do
      "y" ->
        play()

      "n" ->
        @system_module.halt(0)

      _ ->
        @io_module.puts("Invalid option.")
        play_again()
    end
  end

  @spec move_until_win(Game.t()) :: :ok
  defp move_until_win(game) do
    case move(game) do
      {:ok, {:winner, {player, how, reason}}} ->
        @io_module.puts("##########")
        @io_module.puts("Player #{player} won!")
        @io_module.puts("#{player} won #{how}ly by #{reason}")
        @io_module.puts("##########")

      {:ok, game} ->
        draw_board(game)
        move_until_win(game)

      {:error, :already_set} ->
        @io_module.puts(
          IO.ANSI.red() <> "\nError: field already set. Try again." <> IO.ANSI.default_color()
        )

        move_until_win(game)
    end

    :ok
  end

  @spec draw_board(Game.t()) :: :ok
  defp draw_board(game) do
    @io_module.puts("\nCurrent board:")
    @io_module.write("Column 1 2 3 ")

    for i <- 0..8 do
      value = elem(game.board, i) || "-"

      if rem(i, 3) == 0 do
        row = trunc(i / 3 + 1)
        @io_module.write("\n")
        @io_module.write("Row #{row}: #{value}")
      else
        @io_module.write("|#{value}")
      end
    end

    :ok
  end

  @spec move(Game.t()) :: {:ok, Game.t() | {:winner, term}} | {:error, term}
  defp move(game) do
    @io_module.puts(
      IO.ANSI.bright() <> "\n\nIt's #{game.current_player}'s turn." <> IO.ANSI.normal()
    )

    row = parse_1_2_3("row")
    column = parse_1_2_3("column")

    params = %{
      id: game.id,
      player: game.current_player,
      column: column,
      row: row
    }

    MakeMove.call(params)
  end

  @spec parse_1_2_3(String.t()) :: 1 | 2 | 3
  defp parse_1_2_3(row_or_column) do
    user_value = "Which #{row_or_column}? (1,2,3): " |> @io_module.gets() |> String.trim()

    if(user_value in ["1", "2", "3"]) do
      String.to_integer(user_value)
    else
      @io_module.puts("Only 1, 2, or 3 are valid options. Try again.")
      parse_1_2_3(row_or_column)
    end
  end

  defp start_game() do
    start_player = "Who is starting? (x/o): " |> @io_module.gets() |> String.trim()

    if start_player in ["o", "x"] do
      @io_module.puts("Player #{start_player} is starting.")
      params = %{starter: String.to_atom(start_player)}
      TicTacToe.Actions.NewGame.call(params)
    else
      @io_module.puts("Only x or o is a valid starting player.")
      start_game()
    end
  end
end
