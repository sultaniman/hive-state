defmodule Hive.TelemetryStore do
  use Agent, restart: :temporary
  alias Hive.Vehicle

  @mod __MODULE__
  @max_telemetry_count 100

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: @mod)
  end

  def add(%Vehicle{id: id} = vehicle, telemetry) do
    updated = slice([telemetry] ++ get(vehicle))
    Agent.update(@mod, &Map.put(&1, id, updated))
  end

  def truncate(%Vehicle{id: id}) do
    Agent.update(@mod, &Map.put(&1, id, []))
  end

  def get(%Vehicle{id: id}) do
    Agent.get(@mod, &Map.get(&1, id, []))
  end

  defp slice(telemetry_list) do
    if length(telemetry_list) > @max_telemetry_count do
      Enum.slice(telemetry_list, 0..99)
    else
      telemetry_list
    end
  end
end
