use Mix.Config

config :tic_tac_toe, TicTacToe.Games.Game, adapter: TicTacToe.Games.Game.State.GenServer

File.exists?("config/#{Mix.env()}.exs") && import_config "#{Mix.env()}.exs"
