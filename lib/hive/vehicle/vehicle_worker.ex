defmodule Hive.VehicleWorker do
  @moduledoc false
  use GenServer, restart: :transient
  use Hive.Base
  import Hive.Vehicle.Helpers

  # Client
  def start_link(%Vehicle{} = vehicle) do
    GenServer.start_link(@mod, vehicle, name: proc_name(vehicle))
  end

  def update(:position, %Vehicle{} = vehicle, %GeoPosition{} = position) do
    vehicle
    |> proc_name()
    |> GenServer.cast({:update_position, position})
  end

  def update(:online, %Vehicle{} = vehicle) do
    vehicle
    |> proc_name()
    |> GenServer.cast({:online})
  end

  def update(:offline, %Vehicle{} = vehicle) do
    vehicle
    |> proc_name()
    |> GenServer.cast({:offline})
  end

  def get_position(%Vehicle{} = vehicle) do
    vehicle
    |> proc_name()
    |> GenServer.call(:position)
  end

  def get_vehicle(vehicle_id) do
    %Vehicle{id: vehicle_id}
    |> proc_name()
    |> GenServer.call(:get)
  end

  # Server
  @impl true
  def init(%Vehicle{} = vehicle) do
    {:ok, vehicle}
  end

  @impl true
  def handle_cast({:update_position, %GeoPosition{} = position}, %Vehicle{} = vehicle) do
    {:noreply, %{vehicle | position: position}}
  end

  @impl true
  def handle_cast({:online}, %Vehicle{} = vehicle) do
    {:noreply, %{vehicle | online: true}}
  end

  @impl true
  def handle_cast({:offline}, %Vehicle{} = vehicle) do
    {:noreply, %{vehicle | online: false}}
  end

  @impl true
  def handle_call(:position, _from, %Vehicle{} = vehicle) do
    {:reply, vehicle.position, vehicle}
  end

  @impl true
  def handle_call(:get, _from, %Vehicle{} = vehicle) do
    {:reply, vehicle, vehicle}
  end
end
