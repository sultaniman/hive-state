[![Build Status](https://travis-ci.com/hive-fleet/hive-state.svg?branch=develop)](https://travis-ci.com/hive-fleet/hive-state)
[![Coverage Status](https://coveralls.io/repos/github/hive-fleet/hive-state/badge.svg?branch=develop&v=1)](https://coveralls.io/github/hive-fleet/hive-state?branch=master)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)
[![Hex.pm](https://img.shields.io/hexpm/l/hive?color=ff69b4&label=License)](https://opensource.org/licenses/Apache-2.0)

<p align="center">
  <h1 align="center">Hive</h1>
  <p align="center">
    <img width="150" height="150" src="https://raw.githubusercontent.com/hive-fleet/hive-state/develop/assets/logo.svg"/>
  </p>
</p>

**NOTE**: Very early stage of development

In-memory fleet state management for fast access and on top of it make calculations using Uber's H3.


## Installation 💾

This library can be installed by adding `hive` to the list of dependencies in
your `mix.exs`:

```elixir
def deps do
  [{:hive, "~> 0.1.0"}]
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
  altitudeAccuracy: float(),
  heading: float(),
  speed: float()
}

%Vehicle{
  id: String.t(),
  vin: String.t() | nil,
  name: String.t() | nil,
  licensePlate: String.t() | nil,
  make: String.t() | nil,
  model: String.t() | nil,
  seatCount: String.t() | nil,
  color: String.t() | nil,
  available: boolean | true,
  hasPassengers: boolean() | false,
  hasSDCCapability: boolean() | false,
  lastKnownPosition: GeoPosition.t() | nil,
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
Hive.H3.index("vehicle-uuid")
Hive.H3.index(%GeoPosition{latitude: 48.8566, longitude: 2.3522})
```

## The future 🌈

More features and integrations with H3 will be available in the future
at the moment the main goal is to stabilize the API and release
the first version with clear documentation how setup and use `Hive`.

## TODO 🚧

* [ ] Fleet counters,
* [ ] Use ETS to store vehicle telemetry,
* [ ] Introduce typespecs,
* [ ] H3 implement
  * [ ] `num_hexagons/1`,
  * [ ] `edge_length_meters/1`,
  * [ ] `edge_length_kilometers/1`,
  * [ ] `hex_area_m2/1`,
  * [ ] `hex_area_km2/1`,
  * [ ] `from_geo/2`,
  * [ ] `to_geo/1`,
  * [ ] `to_geo_boundary/1`,
  * [ ] `to_string/1`,
  * [ ] `from_string/1`,
  * [ ] `get_resolution/1`,
  * [ ] `get_base_cell/1`,
  * [ ] `is_valid/1`,
  * [ ] `is_class3/1`,
  * [ ] `is_pentagon/1`,
  * [ ] `parent/2`,
  * [ ] `children/2`,
  * [ ] `k_ring/2`,
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
