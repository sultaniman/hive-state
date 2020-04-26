defmodule Hive.VehicleWorker do
  use GenServer, restart: :transient
  alias Hive.Vehicle

  @mod __MODULE__

  # Client
  def start_link(%Vehicle{} = vehicle) do
    GenServer.start_link(@mod, vehicle, name: proc_name(vehicle))
  end

  # Server
  @impl true
  def init(%Vehicle{} = vehicle) do
    {:ok, vehicle}
  end

  defp proc_name(%Vehicle{id: id}) do
    {:via, Registry, {VehicleRegistry, "v-#{id}"}}
  end
end
