![Build Status](https://img.shields.io/travis/com/hive-fleet/hive-state/develop?style=for-the-badge)
![Coverage](https://img.shields.io/coveralls/github/hive-fleet/hive-state/develop?style=for-the-badge)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg?style=for-the-badge)](https://houndci.com)
[![Hex.pm](https://img.shields.io/hexpm/l/hive?color=ff69b4&label=License&style=for-the-badge)](https://opensource.org/licenses/Apache-2.0)

<p align="center">
  <h1 align="center">Hive</h1>
  <p align="center">
    <img width="150" height="150" src="https://raw.githubusercontent.com/hive-fleet/hive-state/develop/assets/logo.svg"/>
  </p>
</p>

Efficient in-memory fleet state management.


## Installation 💾

This library can be installed by adding `hive` to the list of dependencies in
your `mix.exs`:

```elixir
def deps do
  [{:hive, "~> 0.0.1"}]
end
```

Add `:hive` to `extra_applications` if necessary.


## Usage 🚀
Once you have it running you can infleet, defleet, update positions, get h3 index for vehicles

```elixir
alias Hive.Vehicle

# Infleet new vehicles
{:ok, _pid} = Hive.infleet("autonomous-vehicle-id")
{:ok, _pid} = Hive.infleet(%Vehicle{id: "autonomous-vehicle-id"})
{:ok, _pid} = Hive.infleet("normal-vehicle-id")
{:ok, _pid} = Hive.infleet(%Vehicle{id: "normal-vehicle-id"})

# Defleet vehicles
{:ok, _pid} = Hive.defleet("normal-vehicle-id")
{:ok, _pid} = Hive.defleet(%Vehicle{id: "normal-vehicle-id"})
```

### Structs

Hive has two structs `Vehicle` and `GeoPosition`

```elixir
%GeoPosition{
  latitude: float(),
  longitude: float(),
  accuracy: float(),
  altitude: float(),
  altitude_accuracy: float(),
  heading: float(),
  speed: float()
}

%Vehicle{
  id: String.t(),
  vin: String.t() | nil,
  name: String.t() | nil,
  license_plate: String.t() | nil,
  make: String.t() | nil,
  model: String.t() | nil,
  seat_count: non_neg_integer() | nil,
  color: String.t() | nil,
  online: boolean() | true,
  has_passengers: boolean() | false,
  is_sdc: boolean() | false,
  position: GeoPosition.t() | nil,
  telemetry: list() | []
}
```

Supervision tree looks like
![observer::Supervision tree](https://raw.githubusercontent.com/hive-fleet/hive-state/develop/assets/supervision-tree.png)

For more usage details please refer to https://hex.pm/packages/hive

### H3 queries 🍪

H3 integration is done via https://github.com/helium/erlang-h3 and at the moment the following
features are supported

```elixir
# Get hexagon index for vehicle or GeoPosition
Hive.H3.index("vehicle-uuid")
Hive.H3.index(%GeoPosition{latitude: 48.8566, longitude: 2.3522})

# H3 index to GeoPosition
H3.index_to_geo("8928308280fffff")
H3.index_to_geo(617_700_169_958_293_503)

# Get geo boundary
H3.to_geo_boundary("8928308280fffff")
H3.to_geo_boundary(613_196_840_967_340_031)

# Get kRing
H3.k_ring("8928308280fffff")
H3.k_ring(613_196_840_967_340_031, 1)
```

For more see `Hive.H3` module documentation.


## The future 🌈

More features and integrations with H3 will be available in the future
at the moment the main goal is to stabilize the API and release
the first version with clear documentation how setup and use `Hive`.

## TODO 🚧

* [ ] Vehicle update APIs,
* [ ] Vehicle + H3 APIs,
* [ ] Refactor internal APIs,
* [ ] Fleet counters,
* [ ] Use ETS to store vehicle telemetry,
* [ ] Introduce typespecs,
* [ ] H3 implement
  * [ ] `num_hexagons/1`,
  * [ ] `edge_length_meters/1`,
  * [ ] `edge_length_kilometers/1`,
  * [ ] `hex_area_m2/1`,
  * [ ] `hex_area_km2/1`,
  * [ ] `get_base_cell/1`,
  * [ ] `is_valid/1`,
  * [ ] `k_ring_distances/2`,
  * [ ] `max_k_ring_size/1`,
  * [ ] `compact/1`,
  * [ ] `uncompact/2`,
  * [ ] `indices_are_neighbors/2`,
  * [ ] `get_unidirectional_edge/2`,
  * [ ] `grid_distance/2`
* [ ] Rest API to handle requests,
* [ ] User interface to manage and visualize fleet on the map,
* [ ] Possibility to use different router backends,
* [ ] Migrate to Horde to support cluster mode https://hex.pm/packages/horde.


## Assets 💄

1. Project logo is from https://www.flaticon.com/free-icon/honeycomb_1598428

<h2 align="center">Enjoy!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h2>
<p align="center">
        ✨ 🍰 ✨&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
