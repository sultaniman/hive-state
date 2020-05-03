defmodule Hive do
  @moduledoc false
  use Hive.Base
  import Hive.Vehicle.Helpers

  @doc """
  Infleet `Vehicle` only by it's id.
  Will return `{:error, {:already_started, pid}}`.
  """
  defdelegate infleet(vehicle_id), to: VehicleSupervisor

  @doc """
  Defleet `Vehicle` only by it's id if there is no process
  then `{:error, :not_found}` returned.
  """
  defdelegate defleet(vehicle_id), to: VehicleSupervisor

  @doc """
  Update position by `vehicle_id`
  """
  def update_position(vehicle_id, %GeoPosition{} = position) do
    VehicleWorker.update(:position, %Vehicle{id: vehicle_id}, position)
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
