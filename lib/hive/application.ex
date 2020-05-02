defmodule Hive.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      {Hive.VehicleSupervisor, []},
      {Registry, keys: :unique, name: Hive.VehicleRegistry},
      {Hive.TelemetryStore, []},
      worker(Cachex, [:hive_cache, []])
    ]

    opts = [strategy: :one_for_one, name: Hive.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
