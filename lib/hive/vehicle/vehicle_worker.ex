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

  def set_online(%Vehicle{} = vehicle) do
    vehicle
    |> proc_name()
    |> GenServer.cast({:set_online, true})
  end

  def set_offline(%Vehicle{} = vehicle) do
    vehicle
    |> proc_name()
    |> GenServer.cast({:set_online, false})
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

  def pickup(%Vehicle{} = vehicle) do
    vehicle
    |> proc_name()
    |> GenServer.cast(:pickup)
  end

  def dropoff(%Vehicle{} = vehicle) do
    vehicle
    |> proc_name()
    |> GenServer.cast(:dropoff)
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
  def handle_cast({:set_online, state}, %Vehicle{} = vehicle) do
    {:noreply, %{vehicle | online: state}}
  end

  @impl true
  def handle_cast(:pickup, %Vehicle{} = vehicle) do
    {:noreply, %{vehicle | has_passengers: true}}
  end

  @impl true
  def handle_cast(:dropoff, %Vehicle{} = vehicle) do
    {:noreply, %{vehicle | has_passengers: false}}
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
