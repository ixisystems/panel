## PROD CONFIG

use Mix.Config

config :panel,
        status: <<"PRODUCTION CONFIG">>,
        listener_port: 4000,
        database: %{
              :poolsize => 5,
              :poolname => :default, # must be an atom
              :url => "127.0.0.1:8091",
              :bucket => "panel",
              :user => "panel",
              :password => "electrity"
        }

config :logger,
  level: :error,
  format: "$time $metadata[$level] $levelpad$message\n"