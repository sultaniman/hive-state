[![Build Status](https://travis-ci.com/hive-fleet/hive-state.svg?branch=master)](https://travis-ci.com/hive-fleet/hive-state)
[![Coverage Status](https://coveralls.io/repos/github/hive-fleet/hive-state/badge.svg?branch=develop&v=1)](https://coveralls.io/github/hive-fleet/hive-state?branch=master)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)
[![Hex.pm](https://img.shields.io/hexpm/l/hive?color=ff69b4&label=License)](https://opensource.org/licenses/Apache-2.0)

<p align="center">
  <h1 align="center">Hive</h1>
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

For more usage details please refer to https://hex.pm/packages/hive

### H3 queries 🍪

H3 integration is done via https://github.com/helium/erlang-h3 and at the moment the following
features are supported

```elixir
Hive.h3_index(vehicle_id, resolution)
```

## The future 🌈

More features and integrations with H3 will be available in the future
at the moment the main goal is to stabilize the API and release
the first version with clear documentation how setup and use `Hive`.

## TODO 🚧

* [x] Tests
  * [x] Start testing w/ telemetry store,
  * [x] Test vehicle worker,
  * [x] Test vehicle supervisor,
  * [x] Test public API
* [ ] CI
  * [ ] Travis,
  * [ ] Coverage,
  * [ ] Reviews,
  * [ ] Codeclimate
* [x] Telemetry store,
* [x] Custom telemetry limit,
* [x] Refactor & cleanup,
* [ ] Fleet counters,
* [ ] Use ETS to store vehicle telemetry,
* [ ] Introduce typespecs,
* [ ] Documentation
  * [ ] Main module documentation Hive moduledoc,
  * [ ] Function documentation,
  * [ ] Usage examples,
  * [ ] Document structs
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
