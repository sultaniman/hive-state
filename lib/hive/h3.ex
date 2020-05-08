defmodule Hive.H3 do
  @moduledoc """
  Interfaces with Erlang H3 and provides abstraction
  layer to work with vehicles or `%GeoPosition{}`.

  ## Usage

    iex> Hive.H3.num_hexagons(resolution)
  """
  use Hive.Base

  @type vehicle_id() :: binary()
  @type h3_index() :: non_neg_integer()
  @type resolution() :: 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15

  @doc """
  Indexes the location at the specified resolution
  """
  @spec index(GeoPosition.t(), resolution()) :: h3_index()
  def index(%GeoPosition{latitude: lat, longitude: lon}, resolution) do
    :h3.from_geo({lat, lon}, resolution)
  end

  @doc """
  Indexes the location for given `vehicle_id` at the specified resolution
  """
  @spec index(vehicle_id(), resolution()) :: h3_index()
  def index(vehicle_id, resolution) do
    position = VehicleWorker.get_position(%Vehicle{id: vehicle_id})
    :h3.from_geo({position.latitude, position.longitude}, resolution)
  end

  @doc """
  Finds the centroid of the index.
  Returns the `%GeoPosition{}`
  """
  @spec index_to_geo(h3_index()) :: GeoPosition.t()
  def index_to_geo(index) do
    {lat, lon} = :h3.to_geo(index)

    %GeoPosition{
      latitude: lat,
      longitude: lon
    }
  end

  @doc """
  Returns the resolution of the index.
  """
  @spec get_resolution(h3_index()) :: resolution()
  def get_resolution(index) do
    :h3.get_resolution(index)
  end

  @doc """
  Check if given index represents a pentagonal cell
  """
  @spec pentagon?(h3_index()) :: boolean()
  def pentagon?(index) do
    :h3.is_pentagon(index)
  end

  @doc """
  Get all hexagons in a k-ring around
  a given center and a distance.
  """
  @spec k_ring(h3_index(), non_neg_integer()) :: list(h3_index())
  def k_ring(index, distance) do
    :h3.k_ring(index, distance)
  end
end
