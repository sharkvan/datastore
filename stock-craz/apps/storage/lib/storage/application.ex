defmodule Storage.Application do
  @moduledoc """
  The Storage Application Service.

  The storage system business domain lives in this application.

  Exposes API to clients such as the `StorageWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Storage.Repo, []),
    ], strategy: :one_for_one, name: Storage.Supervisor)
  end
end
