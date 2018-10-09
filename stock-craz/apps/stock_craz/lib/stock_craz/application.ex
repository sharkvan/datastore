defmodule StockCraz.Application do
  @moduledoc """
  The StockCraz Application Service.

  The stockcraz system business domain lives in this application.

  Exposes API to clients such as the `StockCrazWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(StockCraz.Repo, []),
      supervisor(StockCraz.GenStage.Producers.DividendDeclaration, []),
      supervisor(StockCraz.GenStage.Consumers.DividendDeclaration, []),
    ], strategy: :one_for_one, name: StockCraz.Supervisor)
  end
end
