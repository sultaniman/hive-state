defmodule Hive.Test do
  @moduledoc false
  use ExUnit.Case
  use Hive.Base

  describe "hive :: 🌈 " do
    test "can infleet vehicles" do
      vehicle = %Vehicle{id: "api-vehicle"}
      assert {:ok, _pid} = Hive.infleet(vehicle)
      assert {:ok, _pid} = Hive.infleet("456")
    end

    test "can defleet vehicles" do
      vehicle = %Vehicle{id: "x-vehicle"}
      assert {:ok, _pid} = Hive.infleet(vehicle)
      assert {:ok, _pid} = Hive.infleet("567")
      assert {:ok, _pid} = Hive.defleet(vehicle)
      assert {:ok, _pid} = Hive.defleet("567")
    end

    test "defleeting unknown vehicle returns error" do
      assert {:error, :not_found} = Hive.defleet(%Vehicle{id: "toto"})
      assert {:error, :not_found} = Hive.defleet("678")
    end

    test "can update position" do
      vehicle = %Vehicle{id: "789"}
      position = %GeoPosition{latitude: 1.1, longitude: 1.2}
      assert {:ok, _pid} = Hive.infleet(vehicle)
      Hive.update_position("789", position)
      assert position = Hive.get_position("789")
    end

    test "can get vehicle" do
      vehicle = %Vehicle{id: "890"}
      assert {:ok, _pid} = Hive.infleet(vehicle)
      assert vehicle = Hive.get_vehicle("890")
    end

    test "can check vehicle" do
      vehicle = %Vehicle{id: "901"}
      assert {:ok, _pid} = Hive.infleet(vehicle)
      assert Hive.alive?("901")
      refute Hive.alive?("012")
    end
  end
end
