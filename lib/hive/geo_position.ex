defmodule Hive.GeoPosition do
  @moduledoc false
  alias __MODULE__

  @type t() :: %GeoPosition{
          latitude: float(),
          longitude: float(),
          accuracy: float(),
          altitude: float(),
          altitude_accuracy: float(),
          heading: float(),
          speed: float()
        }

  # Taken from https://developer.mozilla.org/en-US/docs/Web/API/GeolocationCoordinates
  @enforce_keys [:latitude, :longitude]

  defstruct latitude: 0.0,
            longitude: 0.0,
            accuracy: 0.0,
            altitude: 0.0,
            altitude_accuracy: 0.0,
            heading: 0.0,
            speed: 0.0
end
