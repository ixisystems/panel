defmodule Panel.Plugs.Router do 
    use Plug.Router
    require Logger
    import Plug.Conn

    plug :match
    plug :dispatch

    def init(_) do
        Logger.info IO.ANSI.format([:green, "[", :blue, "starting", :green, "]", :yellow," #{__MODULE__}"],true)
    end

    forward "/sample",   to: Panel.Plugs.Routes.Sample

    get "/error" do
        conn
        |> send_resp(500, "Error")
    end

    match _ do
        conn
        |> send_resp(404,"")
    end
    
end