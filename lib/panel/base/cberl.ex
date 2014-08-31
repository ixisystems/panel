defmodule Panel.Base.CBerl do
    use GenServer
    @moduledoc """
    CBerl wrapper.
    """
    def start_link(opts \\ []) do
        GenServer.start_link(__MODULE__, opts, name: __MODULE__)
    end

    defp db do
        Application.get_env(:panel, :database)
    end

    @doc "init"
    def init(_) do
        {:ok, _} = :cberl.start_link(
            db[:poolname], 
            db[:poolsize],
            db[:url] |> String.to_char_list,
            db[:user] |> String.to_char_list,
            db[:password] |> String.to_char_list,
            db[:bucket] |> String.to_char_list,
            Panel.Base.Transcode.Json
        )
    end

    @doc "get"
    def get(opts \\ %{}) do
        :cberl.get(
            db[:poolname], 
            opts[:id] || ""
        )
    end

    @doc "set"
    def set(opts \\ %{}) do
        :cberl.set(
            db[:poolname], 
            opts[:id] || "",
            0,
            opts[:data] || []
        )
    end

    @doc "replace"
    def replace(opts \\ %{}) do
        :cberl.set(
            db[:poolname], 
            opts[:id] || "",
            0,
            opts[:data] || []
        )
    end

    @doc "mget"
    def mget(opts \\ %{}) do
        :cberl.mget(
            db[:poolname], 
            opts[:keys] || []
        )
    end

    @doc "delete"
    def delete(opts \\ %{}) do
        :cberl.remove(
            db[:poolname], 
            opts[:id] || []
        )
    end

end