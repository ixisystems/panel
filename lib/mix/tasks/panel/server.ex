defmodule Mix.Tasks.Panel.Server do
  use Mix.Task

    @shortdoc "Starts Panel Application"
    @recursive true

    @doc """
    Starts default supervisor
    """
    def run([]) do
      Mix.Task.run "app.start", []
      no_halt
    end

    defp no_halt do
      unless iex_running?, do: :timer.sleep(:infinity)
    end

    defp iex_running? do
      Code.ensure_loaded?(IEx) && IEx.started?
    end

end