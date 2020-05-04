defmodule Hive.VehicleWorkerTest do
  use ExUnit.Case
  alias Hive.{
    GeoPosition,
    Vehicle,
    VehicleWorker
  }

  describe "vehicle worker :: 🚗 " do
    test "can start vehicle" do
      {:ok, _pid} = VehicleWorker.start_link(%Vehicle{id: "123"})
      {:ok, _pid} = VehicleWorker.start_link(%Vehicle{id: "321"})
    end

    test "can update position" do
      vehicle = %Vehicle{id: "123"}
      position = %GeoPosition{latitude: 1.1, longitude: 1.2}
      {:ok, _pid} = VehicleWorker.start_link(vehicle)
      VehicleWorker.update(:position, vehicle, position)
      assert position = VehicleWorker.get_position(vehicle)
    end

    test "can get vehicle by id" do
      vehicle = %Vehicle{id: "123", vin: "vinvin"}
      {:ok, _pid} = VehicleWorker.start_link(vehicle)
      assert vehicle = VehicleWorker.get_vehicle(vehicle.id)
    end
  end
end
