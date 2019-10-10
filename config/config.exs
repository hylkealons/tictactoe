use Mix.Config

config :tic_tac_toe, TicTacToe.Games.Game, adapter: TicTacToe.Games.Game.State.GenServer
config :tic_tac_toe, TicTacToeConsole, io_module: IO
config :tic_tac_toe, TicTacToeConsole, system_module: System

File.exists?("config/#{Mix.env()}.exs") && import_config "#{Mix.env()}.exs"
