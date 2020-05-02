defmodule Hive.VehicleSupervisor do
  use DynamicSupervisor
  require Logger

  alias Hive.{Vehicle, VehicleWorker}

  @mod __MODULE__
  @registry Hive.VehicleRegistry

  # Client
  def start_link(arg) do
    DynamicSupervisor.start_link(@mod, arg, name: @mod)
  end

  @doc """
  Infleet `%Vehicle{}` and supervise in case if we need to
  keep more information about `%Vehicle{}`.
  Will return `{:error, {:already_started, pid}}`.
  """
  def infleet(%Vehicle{} = vehicle) do
    DynamicSupervisor.start_child(@mod, {VehicleWorker, vehicle})
  end

  @doc """
  Defleet vehicle, will stop the process and in case
  if there is no process then `{:error, :not_found}` returned.
  """
  def defleet(%Vehicle{} = vehicle) do
    proc_name = VehicleWorker.make_name(vehicle)
    case Registry.lookup(@registry, proc_name) do
      [{pid, _}] ->
        Logger.info("Stopping process name=#{proc_name} with pid=#{inspect(pid)}")
        GenServer.stop(pid)
        {:ok, pid}
      _ ->
        Logger.info("Process not found name=#{proc_name}")
        {:error, :not_found}
    end
  end

  # Server
  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
