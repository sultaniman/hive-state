defmodule Hive.VehicleWorker do
  use GenServer, restart: :transient
  alias Hive.Vehicle

  @mod __MODULE__

  # Client
  def start_link(%Vehicle{} = vehicle) do
    GenServer.start_link(@mod, vehicle)
  end

  # Server
  @impl true
  def init(%Vehicle{} = vehicle) do
    {:ok, vehicle}
  end
end
