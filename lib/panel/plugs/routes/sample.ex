defmodule Panel.Plugs.Routes.Sample do 
    use Plug.Router
    import Plug.Conn
    alias Panel.Plugs.Middleware.Prerouter
    alias Panel.Plugs.Controllers.Sample

    @responsestring "Sample"

    plug :match
    plug :dispatch

    match "/:id", via: [:head, :get] do
        conn
        |> Prerouter.call
        |> Sample.call([id: id])
    end

    match _ do
        conn
        |> send_resp(404, "#{@responsestring} requires an :id in the form /sample/:id\n")
    end
    
end