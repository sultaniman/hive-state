defmodule Hive.Base do
  defmacro __using__(_) do
    quote do
      @mod __MODULE__
      @registry Hive.VehicleRegistry
      @max_telemetry_count Application.get_env(:hive, :max_telemetry_count, 100)

      alias Hive.{
        GeoPosition,
        Vehicle,
        VehicleSupervisor,
        VehicleWorker
      }
    end
  end
end
