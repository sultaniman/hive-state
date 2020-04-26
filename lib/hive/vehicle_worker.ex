defmodule Hive.VehicleWorker do
  use GenServer, restart: :transient
  alias Hive.{GeoPosition, Vehicle}

  @mod __MODULE__

  # Client
  def start_link(%Vehicle{} = vehicle) do
    GenServer.start_link(@mod, vehicle, name: proc_name(vehicle))
  end

  def update(:position, %Vehicle{} = vehicle, %GeoPosition{} = position) do
    GenServer.cast(proc_name(vehicle), {:update_position, position})
  end

  # Server
  @impl true
  def init(%Vehicle{} = vehicle) do
    {:ok, vehicle}
  end

  @impl true
  def handle_cast({:update_position, %GeoPosition{} = position}, %Vehicle{} = vehicle) do
    {:noreply, %{vehicle | lastKnownPosition: position}}
  end

  defp proc_name(%Vehicle{id: id}) do
    {:via, Registry, {VehicleRegistry, "v-#{id}"}}
  end
end
