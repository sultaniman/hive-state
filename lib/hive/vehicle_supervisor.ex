defmodule Hive.VehicleSupervisor do
  use DynamicSupervisor
  alias Hive.{Vehicle, VehicleWorker}

  @mod __MODULE__

  # Client
  def start_link(arg) do
    DynamicSupervisor.start_link(@mod, arg, name: @mod)
  end

  def infleet(%Vehicle{} = vehicle) do
    DynamicSupervisor.start_child(@mod, {VehicleWorker, vehicle})
  end

  def defleet(%Vehicle{} = vehicle) do
    DynamicSupervisor.start_child(@mod, {VehicleWorker, vehicle})
  end

  # Server
  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
