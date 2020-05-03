defmodule Hive.TelemetryStore do
  @moduledoc false
  use Agent, restart: :temporary
  use Hive.Base

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
      Enum.slice(telemetry_list, 0..(@max_telemetry_count - 1))
    else
      telemetry_list
    end
  end
end
