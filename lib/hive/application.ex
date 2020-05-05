defmodule Hive.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    children = [
      {Hive.VehicleSupervisor, []},
      {Registry, keys: :unique, name: Hive.VehicleRegistry},
      {Hive.TelemetryStore, []}
    ]

    opts = [strategy: :one_for_one, name: Hive.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
