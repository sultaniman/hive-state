defmodule Hive.LoadTest do
  @moduledoc false
  use ExUnit.Case
  use Hive.Base

  describe "hive load :: 🚀 " do
    test "infleet 100 vehicles" do
      Enum.map(1..100, &Hive.infleet("id-100-#{&1}"))

      count =
        1..100
        |> Enum.filter(&Hive.has_member?("id-100-#{&1}"))
        |> length()

      assert count == 100
    end

    test "infleet 1_000 vehicles" do
      Enum.map(1..1_000, &Hive.infleet("id-1000-#{&1}"))

      count =
        1..1_000
        |> Enum.filter(&Hive.has_member?("id-1000-#{&1}"))
        |> length()

      assert count == 1_000
    end

    test "infleet 10_000 vehicles" do
      Enum.map(1..10_000, &Hive.infleet("id-1000-#{&1}"))

      count =
        1..10_000
        |> Enum.filter(&Hive.has_member?("id-1000-#{&1}"))
        |> length()

      assert count == 10_000
    end
  end
end
