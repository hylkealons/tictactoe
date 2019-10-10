use Mix.Config

config :tic_tac_toe, TicTacToe.Games.Game, adapter: TicTacToe.Games.Game.State.Ets
config :tic_tac_toe, TicTacToeConsole, io_module: TicTacToe.Support.FakeIO
config :tic_tac_toe, TicTacToeConsole, system_module: TicTacToe.Support.FakeSystem
