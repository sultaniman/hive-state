# Hive

[![Build Status](https://travis-ci.com/hive-fleet/hive-state.svg?branch=master)](https://travis-ci.com/hive-fleet/hive-state)
[![Coverage Status](https://coveralls.io/repos/github/hive-fleet/hive-state/badge.svg?branch=develop&v=1)](https://coveralls.io/github/hive-fleet/hive-state?branch=master)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)

Keep your fleet state in-memory for fast access and on top of it make calculations using Uber's H3.

## Usage
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

## Installation

This library can be installed by adding `hive` to the list of dependencies in
your `mix.exs`:

```elixir
def deps do
  [{:hive, "~> 0.1.0"}]
end
```

https://hex.pm/packages/hive

## TODO

* [x] Tests,
  * [x] Start testing w/ telemetry store,
  * [x] Test vehicle worker,
  * [x] Test vehicle supervisor,
  * [x] Test public API
* [x] Telemetry store,
* [x] Custom telemetry limit,
* [x] Refactor & cleanup,
* [ ] Use ETS to store vehicle telemetry,
* [ ] Documentation
  * [ ] Main module documentation Hive moduledoc,
  * [ ] Function documentation,
  * [ ] Usage examples,
  * [ ] Document structs

Icons from https://www.flaticon.com/free-icon/honeycomb_1598428

Have fun!

---------------------------------------------------------------------

<p align="center">
  ✨ 🍰 ✨&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
