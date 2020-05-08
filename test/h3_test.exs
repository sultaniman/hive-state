defmodule Hive.H3Test do
  @moduledoc false
  use ExUnit.Case
  use Hive.Base

  describe "H3 :: ⚽️ " do
    test "can get h3 index for vehicle" do
      vehicle = %Vehicle{id: "1234"}
      Hive.infleet(vehicle)
      Hive.update_position(vehicle.id, %GeoPosition{latitude: 1.1, longitude: 1.2})
      assert Hive.alive?("1234")
      assert 614_552_350_213_799_935 == Hive.H3.index("1234", 8)
    end

    test "can get h3 index for GeoPosition" do
      position = %GeoPosition{latitude: 48.8566, longitude: 2.3522}
      assert 613_047_304_015_839_231 == Hive.H3.index(position, 8)
    end

    test "k_ring works as expected" do
      hexagons =
        "8928308280fffff"
        |> String.to_charlist()
        |> :h3.from_string()
        |> Hive.H3.k_ring(1)
        |> Enum.map(&:h3.to_string/1)
        |> Enum.map(&List.to_string/1)
        |> MapSet.new()

      assert MapSet.new([
        "8928308280fffff",
        "8928308280bffff",
        "89283082807ffff",
        "89283082877ffff",
        "89283082803ffff",
        "89283082873ffff",
        "8928308283bffff"
      ]) == hexagons
    end
  end
end
