defmodule Hive.Vehicle.Helpers do
  @moduledoc false
  use Hive.Base

  def make_name(%Vehicle{id: id}), do: "v-#{id}"

  def proc_name(%Vehicle{} = vehicle) do
    {:via, Registry, {@registry, make_name(vehicle)}}
  end
end
