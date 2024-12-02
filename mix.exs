defmodule Apartmentex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :apartmentex,
      version: "0.3.0",
      elixir: "~> 1.17",
      description: "SaaS Library for Ecto applications using Postgres or Mysql",
      package: [
        links: %{"Github" => "https://github.com/Dania02525/apartmentex"},
        maintainers: ["Dania Simmons"],
        licenses: ["MIT"]
      ],
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:ecto, :ecto_sql, :logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ecto, "~> 3.12"},
      {:ecto_sql, "~> 3.12"},
      {:myxql, "~> 0.7.0", optional: true},
      {:postgrex, ">= 0.11.0", optional: true},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp elixirc_paths(:test), do: elixirc_paths() ++ ["test/support"]
  defp elixirc_paths(_), do: elixirc_paths()
  defp elixirc_paths, do: ["lib"]
end
