defmodule Hive.Vehicle do
  @moduledoc false
  alias Hive.GeoPosition
  alias __MODULE__

  @enforce_keys [:id]
  defstruct id: "",
            vin: "",
            name: "",
            license_plate: "",
            make: "",
            model: "",
            seat_count: 2,
            color: "",
            online: true,
            has_passengers: false,
            is_sdc: false,
            telemetry: [],
            position: %Hive.GeoPosition{
              latitude: 0.0,
              longitude: 0.0
            }

  @type t() :: %Vehicle{
          id: String.t(),
          vin: String.t() | nil,
          name: String.t() | nil,
          license_plate: String.t() | nil,
          make: String.t() | nil,
          model: String.t() | nil,
          seat_count: String.t() | nil,
          color: String.t() | nil,
          online: boolean() | true,
          has_passengers: boolean() | false,
          is_sdc: boolean() | false,
          position: GeoPosition.t() | nil,
          telemetry: list() | []
        }
end
