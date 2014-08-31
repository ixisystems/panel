defmodule Panel.Plugs.Controllers.Default do
    import Plug.Conn
    alias Panel.Base.CBerl
    require Logger

    def init(_) do
    end

    def call(conn, opts \\ []) do
        args = %{:id => Keyword.get(opts, :id, "") <> Keyword.get(opts, :suffix , "")}
        case args |> CBerl.get do
            {_key, _cas, record}
                ->  case Logger.level do 
                        :debug -> Logger.debug (record |> inspect) 
                        _      -> true
                    end
                    conn |> send_resp(200, record |> inspect)
            {key, {:error, :key_enoent}}
                ->  case Logger.level do 
                        :debug -> Logger.debug "{\"id\":\"#{key}\", \"status\":\"not found\"}" 
                        _      -> true
                    end
                    conn |> send_resp(404, "{\"id\":\"#{key}\", \"status\":\"not found\"}\n")
            issue
                ->  case Logger.level do 
                        :debug -> Logger.debug (issue |> inspect) 
                        _      -> true
                    end
                    conn |> send_resp(500, issue |> inspect)
        end
    end
end