defmodule Hive.MixProject do
  use Mix.Project

  @vsn "0.1.0"
  @deps [
    {:h3, "~> 3.6"},
    {:cachex, "~> 3.2"},
    {:credo, "~> 1.4", only: [:dev, :test], runtime: false}
  ]

  def project do
    [
      app: :hive,
      version: @vsn,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: @deps
    ]
  end

  def application do
    [
      extra_applications: [:logger, :cachex],
      mod: {Hive.Application, []}
    ]
  end
end
