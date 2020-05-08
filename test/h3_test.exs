defmodule Hive.H3Test do
  @moduledoc false
  use ExUnit.Case
  use Hive.Base
  alias Hive.H3

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

      assert position = H3.index_to_geo("8928308280fffff")
      assert position = H3.index_to_geo(617_700_169_958_293_503)
    end

    test "index_from_geo/2 works as expected" do
      paris = %GeoPosition{
        latitude: 48.8566,
        longitude: 2.3522
      }

      assert 613_047_304_015_839_231 == H3.index_from_geo(paris, 8)
    end

    test "to_geo_boundary/1 works as expected" do
      paris_index = 613_047_304_015_839_231
      paris_bounds = [
        %Hive.GeoPosition{latitude: 48.85884506529458, longitude: 2.3526566175076393},
        %Hive.GeoPosition{latitude: 48.85769910065315, longitude: 2.3463415968651824},
        %Hive.GeoPosition{latitude: 48.85319382376231, longitude: 2.345015248718628},
        %Hive.GeoPosition{latitude: 48.8498348107989, longitude: 2.3500032743113586},
        %Hive.GeoPosition{latitude: 48.8509808618284, longitude: 2.356317312666095},
        %Hive.GeoPosition{latitude: 48.85548583942441, longitude: 2.357644307615529}
      ]
      assert paris_bounds == H3.to_geo_boundary(paris_index)
      assert paris_bounds == H3.to_geo_boundary(H3.to_string(paris_index))
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
  end
end
