defmodule Hive.TelemetryStoreTest do
  use ExUnit.Case
  alias Hive.{TelemetryStore, Vehicle}

  setup do
    on_exit(fn ->
      TelemetryStore.truncate(%Vehicle{id: "vehicle-1"})
    end)

    :ok
  end

  describe "telemetry :: 📡 " do
    test "it works as expected" do
      vehicle = %Vehicle{id: "vehicle-1"}
      telemetry = %{fuelLevel: 0.8}

      TelemetryStore.add(
        vehicle,
        telemetry
      )

      assert TelemetryStore.get(vehicle) == [telemetry]
    end

    test "truncate works as expected" do
      vehicle = %Vehicle{id: "vehicle-1"}
      telemetry = %{fuelLevel: 0.8}

      TelemetryStore.add(
        vehicle,
        telemetry
      )

      TelemetryStore.truncate(vehicle)
      assert TelemetryStore.get(vehicle) == []
    end

    test "only 100 items are stored" do
      vehicle = %Vehicle{id: "vehicle-1"}

      Enum.map(
        1..200,
        &TelemetryStore.add(vehicle, %{currentSpeed: &1})
      )

      telemetry = TelemetryStore.get(vehicle)
      assert length(telemetry) == 100

      [last | _rest] = telemetry
      assert last[:currentSpeed] == 200
    end

    test "new telemetry added to front" do
      vehicle = %Vehicle{id: "vehicle-1"}
      TelemetryStore.add(vehicle, %{one: 1})
      TelemetryStore.add(vehicle, %{two: 2})
      TelemetryStore.add(vehicle, %{three: 3})

      assert TelemetryStore.get(vehicle) == [
               %{three: 3},
               %{two: 2},
               %{one: 1}
             ]
    end
  end
end
