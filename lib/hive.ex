defmodule Hive do
  @moduledoc false
  alias Hive.{
    GeoPosition,
    Vehicle,
    VehicleSupervisor,
    VehicleWorker
  }

  @doc """
  Infleet `Vehicle` only by it's id.
  Will return `{:error, {:already_started, pid}}`.
  """
  def infleet(vehicle_id) when is_binary(vehicle_id) do
    infleet(%Vehicle{id: vehicle_id})
  end

  @doc """
  Infleet `%Vehicle{}` and supervise in case if we need to
  keep more information about `%Vehicle{}`.
  Will return `{:error, {:already_started, pid}}`.
  """
  def infleet(%Vehicle{} = vehicle) do
    VehicleSupervisor.infleet(vehicle)
  end

  @doc """
  Defleet `Vehicle` only by it's id if there is no process
  then `{:error, :not_found}` returned.
  """
  def defleet(vehicle_id) when is_binary(vehicle_id) do
    defleet(%Vehicle{id: vehicle_id})
  end

  @doc """
  Defleet vehicle, will stop the process and in case
  if there is no process then `{:error, :not_found}` returned.
  """
  def defleet(%Vehicle{} = vehicle) do
    VehicleSupervisor.defleet(vehicle)
  end

  def update_position(%Vehicle{} = vehicle, %GeoPosition{} = position) do
    VehicleWorker.update(:position, vehicle, position)
  end

  def h3_index(%Vehicle{} = vehicle, resolution) do
    VehicleWorker.h3(:index, vehicle, resolution)
  end
end
