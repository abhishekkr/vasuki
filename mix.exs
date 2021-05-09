defmodule Vasuki.MixProject do
  use Mix.Project

  def project do
    [
      app: :vasuki,
      version: "0.1.2",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      description: description(),
      package: package(),

      name: "Vasuki",
      source_url: "https://github.com/abhishekkr/vasuki",
      homepage_url: "https://github.com/abhishekkr/vasuki",
      docs: [
        main: "Vasuki", ## main page in docs
        logo: "./vasuki.png",
        extras: ["README.md"]
      ],

      ## excoveralls config
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Vasuki.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:excoveralls, "~> 0.14.0", only: :test},  ## test coverage
      {:ex_doc, "~> 0.24.2", only: :dev, runtime: false}  ## load only in dev mode
    ]
  end



  defp description() do
    "Provides different constructs. Currently DirWalk and Mucket."
  end

  defp package() do
    [
      name: "vasuki",
      # These are the default files included in the package
      files: ~w(config lib .formatter.exs mix.exs README.md LICENSE),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/abhishekkr/vasuki"}
    ]
  end
end
