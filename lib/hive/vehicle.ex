defmodule Hive.Vehicle do
  alias Hive.GeoPosition
  alias __MODULE__

  @enforce_keys [:id]
  defstruct id: "",
            vin: "",
            name: "",
            licensePlate: "",
            make: "",
            model: "",
            seatCount: 2,
            color: "",
            available: true,
            hasPassengers: false,
            hasSDCCapability: false,
            telemetry: [],
            lastKnownPosition: %Hive.GeoPosition{
              latitude: 0.0,
              longitude: 0.0
            }

  @type t() :: %Vehicle{
          id: String.t(),
          vin: String.t() | nil,
          name: String.t() | nil,
          licensePlate: String.t() | nil,
          make: String.t() | nil,
          model: String.t() | nil,
          seatCount: String.t() | nil,
          color: String.t() | nil,
          available: boolean | true,
          hasPassengers: boolean() | false,
          hasSDCCapability: boolean() | false,
          lastKnownPosition: GeoPosition.t() | nil,
          telemetry: list() | []
        }
end
