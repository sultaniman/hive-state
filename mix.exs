defmodule Hive.MixProject do
  use Mix.Project

  @vsn "0.0.1"

  @deps [
    {:h3, "~> 3.6"},
    {:ex_doc, "~> 0.21", only: :dev, runtime: false},
    {:excoveralls, "~> 0.12", only: :test},
    {:inch_ex, github: "rrrene/inch_ex", only: [:dev, :test]},
    {:credo, "~> 1.4", only: [:dev, :test], runtime: false}
  ]

  @package [
    name: "hive",
    files: ~w(lib .formatter.exs mix.exs README* LICENSE*),
    licenses: ["Apache 2.0"],
    links: %{"GitHub" => "https://github.com/hive-fleet/hive-state"}
  ]

  @description "In-memory fleet state management"

  def project do
    [
      app: :hive,
      version: @vsn,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: @deps,
      description: @description,
      package: @package,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      # Docs
      name: "Hive state",
      source_url: "https://github.com/hive-fleet/hive-state",
      homepage_url: "https://github.com/hive-fleet",
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Hive.Application, []}
    ]
  end
end
