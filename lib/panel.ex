defmodule Panel do
  use Application
  require Logger
  alias Panel.Base.Import.Sample

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    [db, config, version, listens_on] = appvars([:database, :status, :version, :listener_port])
    Logger.info IO.ANSI.format([:green, "[", :blue, "starting", :green, "] Panel application at port:" <> Integer.to_string(listens_on) <> " starting version@" <> version <>  " with config: " <> config <> " (" <> db.url <> ")"], true)

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Panel.Plugs.Router, [], [port: listens_on]),
      worker(Panel.Base.CBerl, [], restart: :permanent)
    ]

    opts = [strategy: :one_for_one, name: :Panel.Supervisor]
    sup = Supervisor.start_link(children, opts)
    case Mix.env do
        :local
          -> Sample.load_sampledata("data/sampledata.csv", true)
        _ 
          -> true
    end
    sup
  end

  def appvars(vars) do
    vars
    |> Enum.map fn(var) -> Application.get_env(:panel, var) end
  end

end