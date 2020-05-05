defmodule Hive.VehicleSupervisorTest do
  use ExUnit.Case

  alias Hive.{
    Vehicle,
    VehicleSupervisor
  }

  alias Hive.Vehicle.Helpers

  describe "vehicle supervisor :: 🚔 " do
    test "can infleet vehicle" do
      vehicle = %Vehicle{id: "new-vehicle"}
      assert {:ok, pid} = VehicleSupervisor.infleet(vehicle)
    end

    test "can defleet vehicle" do
      vehicle = %Vehicle{id: "defleet-vehicle"}
      assert {:ok, infleet_pid} = VehicleSupervisor.infleet(vehicle)
      assert {:ok, defleet_pid} = VehicleSupervisor.defleet(vehicle)
      assert infleet_pid == defleet_pid
    end

    test "defleeting unknown vehicle returns error" do
      vehicle = %Vehicle{id: "ufo-vehicle"}
      assert {:error, :not_found} = VehicleSupervisor.defleet(vehicle)
    end

    test "can check fleet membership" do
      vehicle = %Vehicle{id: "check-vehicle"}
      proc_name = Helpers.make_name(vehicle)
      assert {:ok, _pid} = VehicleSupervisor.infleet(vehicle)
      assert VehicleSupervisor.member?(proc_name)
    end

    test "can get vehicle by id" do
      vehicle = %Vehicle{id: "get-vehicle"}
      assert {:ok, _pid} = VehicleSupervisor.infleet(vehicle)
      assert vehicle = VehicleSupervisor.get_vehicle(vehicle.id)
    end

    test "can not start duplicate process" do
      vehicle = %Vehicle{id: "get-vehicle"}
      assert {:error, {:already_started, _pid}} = VehicleSupervisor.infleet(vehicle)
    end
  end
end
