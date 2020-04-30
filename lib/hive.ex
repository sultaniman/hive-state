defmodule Hive do
  @moduledoc false
  alias Hive.{
    GeoPosition,
    Vehicle,
    VehicleSupervisor,
    VehicleWorker
  }

  def infleet(%Vehicle{} = vehicle) do
    VehicleSupervisor.infleet(vehicle)
  end

  def defleet(%Vehicle{} = vehicle) do
    VehicleSupervisor.defleet(vehicle)
  end

  def update_position(%Vehicle{} = vehicle, %GeoPosition{} = position) do
    VehicleWorker.update(:position, vehicle, position)
  end
end
