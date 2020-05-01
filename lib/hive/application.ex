defmodule Hive.Application do
  @moduledoc false
  use Application

  @opts [strategy: :one_for_one, name: Hive.Supervisor]
  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      {Hive.VehicleSupervisor, []},
      {Registry, keys: :unique, name: Hive.VehicleRegistry},
      {Hive.TelemetryStore, []},
      worker(Cachex, [:hive_cache, []]),
    ]

    Supervisor.start_link(children, @opts)
  end
end
