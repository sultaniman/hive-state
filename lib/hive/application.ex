defmodule Hive.Application do
  @moduledoc false
  use Application

  @opts [strategy: :one_for_one, name: Hive.Supervisor]
  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      {Hive.VehicleSupervisor, []},
      {Registry, keys: :unique, name: VehicleRegistry},
      worker(Cachex, [:hive_cache, []])
      # {Registry, keys: :unique, name: TelemetryRegistry}
    ]

    Supervisor.start_link(children, @opts)
  end
end
