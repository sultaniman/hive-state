defmodule Hive do
  @moduledoc """
  Efficient in-memory fleet state management
  where each vehicle is a separate process
  which manages it's own state and provides
  APIs to access and use it.

  Public API exposed under Hive module.
  """
  use Hive.Base
  import Hive.Vehicle.Helpers

  @doc """
  Infleet by `vehicle_id`, when vehicle infleeted
  only by `vehicle_id` then the state of `VehicleWorker`
  initialized as `%Vehicle{id: vehicle_id}`.
  If you want to pass more metadata consider passing
  `%Vehicle{}` struct instead of binary.
  Will return `{:error, {:already_started, pid}}`.
  """
  def infleet(vehicle_id) when is_binary(vehicle_id) do
    VehicleSupervisor.infleet(%Vehicle{id: vehicle_id})
  end

  @doc """
  Infleet `Vehicle`
  Will return `{:error, {:already_started, pid}}`.
  """
  def infleet(%Vehicle{} = vehicle) do
    VehicleSupervisor.infleet(vehicle)
  end

  @doc """
  Defleet by `vehicle_id`
  then `{:error, :not_found}` returned.
  """
  def defleet(vehicle_id) when is_binary(vehicle_id) do
    VehicleSupervisor.defleet(%Vehicle{id: vehicle_id})
  end

  @doc """
  Defleet `Vehicle` if not known
  then `{:error, :not_found}` returned.
  """
  def defleet(%Vehicle{} = vehicle) do
    VehicleSupervisor.defleet(vehicle)
  end

  @doc """
  Update position by `vehicle_id`
  """
  def update_position(vehicle_id, %GeoPosition{} = position) do
    VehicleWorker.update(:position, %Vehicle{id: vehicle_id}, position)
  end

  @doc """
  Get position by `vehicle_id`
  """
  def get_position(vehicle_id) do
    %Vehicle{id: vehicle_id}
    |> proc_name()
    |> GenServer.call(:position)
  end

  @doc """
  Get vehicle by `vehicle_id`
  """
  def get_vehicle(vehicle_id) do
    %Vehicle{id: vehicle_id}
    |> proc_name()
    |> GenServer.call(:get)
  end

  @doc """
  Sets vehicle online
  """
  def set_online(vehicle_id) do
    VehicleWorker.set_online(%Vehicle{id: vehicle_id})
  end

  @doc """
  Sets vehicle offline
  """
  def set_offline(vehicle_id) do
    VehicleWorker.set_offline(%Vehicle{id: vehicle_id})
  end

  @doc """
  Change state has_passengers to true
  """
  def pickup(vehicle_id) do
    VehicleWorker.pickup(%Vehicle{id: vehicle_id})
  end

  @doc """
  Sets state has_passengers to false
  """
  def dropoff(vehicle_id) do
    VehicleWorker.dropoff(%Vehicle{id: vehicle_id})
  end

  @doc """
  Check if vehicle is known and supervised
  """
  def alive?(vehicle_id) do
    %Vehicle{id: vehicle_id}
    |> make_name()
    |> VehicleSupervisor.alive?()
  end
end
