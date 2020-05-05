defmodule Hive do
  @moduledoc """

  """
  use Hive.Base
  import Hive.Vehicle.Helpers

  @doc """
  Infleet by `vehicle_id`.
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
  Check if vehicle is known and supervised
  """
  def has_member?(vehicle_id) do
    %Vehicle{id: vehicle_id}
    |> make_name()
    |> VehicleSupervisor.member?()
  end

  def h3_index(vehicle_id, resolution) do
    VehicleWorker.h3(:index, %Vehicle{id: vehicle_id}, resolution)
  end
end
