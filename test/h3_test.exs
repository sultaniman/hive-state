defmodule Hive.H3Test do
  @moduledoc false
  use ExUnit.Case
  use Hive.Base
  alias Hive.H3

  def geo_positions_to_tuples(positions) do
    positions
    |> Enum.map(&{
      Float.round(&1.latitude, 10),
      Float.round(&1.longitude, 10)
    })
  end

  describe "H3 :: ⚽️ " do
    test "can get h3 index for vehicle" do
      vehicle = %Vehicle{id: "1234"}
      Hive.infleet(vehicle)
      Hive.update_position(vehicle.id, %GeoPosition{latitude: 1.1, longitude: 1.2})
      assert Hive.alive?("1234")
      assert 614_552_350_213_799_935 == H3.index("1234", 8)
    end

    test "can get h3 index for GeoPosition" do
      position = %GeoPosition{latitude: 48.8566, longitude: 2.3522}
      assert 613_047_304_015_839_231 == H3.index(position, 8)
    end

    test "from_string/1 works as expected" do
      assert H3.from_string("8928308280fffff") == 617_700_169_958_293_503
    end

    test "to_string/1 works as expected" do
      assert H3.to_string(617_700_169_958_293_503) == "8928308280fffff"
    end

    test "index_to_geo/1 works as expected" do
      position = %GeoPosition{
        latitude: 37.77670234943567,
        longitude: -122.41845932318311
      }

      assert position == H3.index_to_geo("8928308280fffff")
      assert position == H3.index_to_geo(617_700_169_958_293_503)
    end

    test "index_from_geo/2 works as expected" do
      paris = %GeoPosition{
        latitude: 37.3615593,
        longitude: -122.0553238
      }

      assert 613_196_840_967_340_031 == H3.index_from_geo(paris, 8)
    end

    test "to_geo_boundary/1 works as expected" do
      paris_index = 613_196_840_967_340_031
      paris_bounds = MapSet.new([
        {Float.round(37.35289791086641, 10), Float.round(-122.05623286127619, 10)},
        {Float.round(37.354077271554004, 10), Float.round(-122.06213998202213, 10)},
        {Float.round(37.35643717847348, 10), Float.round(-122.05175455716366, 10)},
        {Float.round(37.35879583478516, 10), Float.round(-122.06356934373095, 10)},
        {Float.round(37.36115592680977, 10), Float.round(-122.05318357743447, 10)},
        {Float.round(37.362335222443996, 10), Float.round(-122.05909124330346, 10)}
      ])

      with_index =
        paris_index
        |> H3.to_geo_boundary()
        |> geo_positions_to_tuples()

      with_string_index =
        paris_index
        |> H3.to_string()
        |> H3.to_geo_boundary()
        |> geo_positions_to_tuples()

      assert paris_bounds == MapSet.new(with_index)
      assert paris_bounds == MapSet.new(with_string_index)
    end

    test "k_ring works as expected" do
      hexagons =
        "8928308280fffff"
        |> H3.from_string()
        |> H3.k_ring(1)
        |> Enum.map(&H3.to_string/1)
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

    test "get_resolution/1 works as expected" do
      resolution =
        "89080000003ffff"
        |> H3.from_string()
        |> H3.get_resolution()

      assert resolution == 9
    end

    test "pentagon?/1 works as expected" do
      is_pentagon =
        "851c0003fffffff"
        |> H3.from_string()
        |> H3.pentagon?()

      assert is_pentagon
    end
  end
end
