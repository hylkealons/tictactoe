defmodule TicTacToe.Support.FakeIO do
  @moduledoc """
  FakeIO helps with testing the Console module. It works together with ETS and fakes input.
  """
  @ansi_red IO.ANSI.red()

  def puts("Player x won!"), do: send(self(), {:player_won, :x})
  def puts("Player o won!"), do: send(self(), {:player_won, :o})

  def puts(@ansi_red <> "\nError: field already set. Try again." <> _),
    do: send(self(), {:error, :already_set})

  def puts(_), do: :ok
  def write(_), do: :ok

  def gets("Who is starting? (x/o): "), do: "x"
  def gets("Do you want to play again? (y/n): "), do: "n"

  def gets("Which row? (1,2,3): ") do
    [{_, row} | left] = :ets.take(:board, "row")
    :ets.insert(:board, left)
    to_string(row)
  end

  def gets("Which column? (1,2,3): ") do
    [{_, column} | left] = :ets.take(:board, "column")
    :ets.insert(:board, left)
    to_string(column)
  end
end
