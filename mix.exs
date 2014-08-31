defmodule Panel.Mixfile do
  use Mix.Project

  @version File.read!("VERSION") |> String.strip

  def project do
    [app: :panel,
     name: "Panel",
     version: @version,
     elixir: "~> 1.0.0-rc1",
     build_per_environment: true,
     deps: deps]
  end

  def application do
    [applications: [:cowboy, :plug, :logger],
      env: [version: @version],
      mod: {Panel, []}
    ]
  end

  def compilers(_) do
    [:elixir, :app]
  end

  defp deps do
    [ { :cowboy, "~> 1.0.0"},
      { :plug,   "~> 0.7.0"},
      { :cberl,       github: "chitika/cberl", override: true},
      { :email,       github: "kivra/email" },
      { :hackney,     github: "benoitc/hackney", tag: "0.13.1" , override: true},
      { :jazz,        github: "meh/jazz", override: true},
    ]
  end
end
