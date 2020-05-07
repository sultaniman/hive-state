defmodule Hive.H3 do
  @moduledoc """
  Interfaces with Erlang H3 and provides abstraction
  layer to work with vehicles or `%GeoPosition{}`.

  ## Usage

    iex> Hive.H3.num_hexagons(resolution)
  """
  use Hive.Base

  @doc """
  Indexes the location at the specified resolution
  """
  def index(%GeoPosition{latitude: lat, longitude: lon}, resolution) do
    :h3.from_geo({lat, lon}, resolution)
  end

  @doc """
  Indexes the location for given `vehicle_id` at the specified resolution
  """
  def index(vehicle_id, resolution) do
    position = VehicleWorker.get_position(%Vehicle{id: vehicle_id})
    :h3.from_geo({position.latitude, position.longitude}, resolution)
  end
end
