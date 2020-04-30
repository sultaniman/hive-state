defmodule Hive.VehicleWorker do
  use GenServer, restart: :transient
  alias Hive.{GeoPosition, Vehicle}

  @mod __MODULE__

  # Client
  def start_link(%Vehicle{} = vehicle) do
    GenServer.start_link(@mod, vehicle, name: proc_name(vehicle))
  end

  def update(:position, %Vehicle{} = vehicle, %GeoPosition{} = position) do
    vehicle
    |> proc_name()
    |> GenServer.cast({:update_position, position})
  end

  def get_position(%Vehicle{} = vehicle) do
    vehicle
    |> proc_name()
    |> GenServer.call(:position)
  end

  def h3(:index, %Vehicle{} = vehicle, resolution) do
    position = get_position(vehicle)
    :h3.from_geo({position.latitude, position.longitude}, resolution)
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

  @impl true
  def handle_call(:position, _from, %Vehicle{} = vehicle) do
    {:reply, vehicle.lastKnownPosition, vehicle}
  end

  defp proc_name(%Vehicle{id: id}) do
    {:via, Registry, {VehicleRegistry, "v-#{id}"}}
  end
end
