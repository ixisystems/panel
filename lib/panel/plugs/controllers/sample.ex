defmodule Panel.Plugs.Controllers.Sample do 
    alias Panel.Plugs.Controllers.Default

    def init(_) do
    end

    def call(conn, opts \\ []) do
        opts = Keyword.put(opts, :suffix, "")
        conn
        |> Default.call(opts)
    end
    
end