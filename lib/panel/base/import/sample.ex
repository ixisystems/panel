defmodule Panel.Base.Import.Sample do
  alias Panel.Base.CBerl

  def sample do
    %{id: nil,
      name: nil,
      phone: nil}
  end

  @doc """
  Reads a CSV format file at the given path, and creates agent records in Couchbase
  """
  def load_sampledata(path, reload \\ false) do
    File.stream!(path)
    |> Stream.map(
      fn(line) ->
        [id,name,phone] =
          case String.split(String.strip(line), "\t") do
            [id,name,phone] 
              ->  [id,name,phone]
          end
        %{sample |
          id: id,
          name: name,
          phone: phone
        }
      end
    )
    |> Stream.map(
        fn(sample) ->
          # IO.puts "Loading sample: #{inspect(sample)}"
          case reload do
            true
              -> CBerl.replace(%{:id => sample[:id] <> "_sample", :data => sample})
            _
              -> CBerl.set(%{:id => sample[:id] <> "_sample", :data => sample})
          end
        end
      )
    |> Enum.uniq
  end
end
