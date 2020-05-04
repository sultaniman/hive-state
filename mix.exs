defmodule Hive.MixProject do
  use Mix.Project

  @vsn "0.1.0"
  @deps [
    {:h3, "~> 3.6"},
    {:ex_doc, "~> 0.21", only: :dev, runtime: false},
    {:credo, "~> 1.4", only: [:dev, :test], runtime: false}
  ]

  def project do
    [
      app: :hive,
      version: @vsn,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: @deps,

      # Docs
      name: "Hive state",
      source_url: "https://github.com/hive-fleet/hive-state",
      homepage_url: "https://github.com/hive-fleet",
      docs: [
        main: "Hive",
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
