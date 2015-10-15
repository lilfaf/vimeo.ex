defmodule Vimeo.Parser do
  @moduledoc """
  Defines parsing functionality to convert data Maps to the suitable module.
  """

  @doc """
  Parse response data Map to struct.
  """
  @spec parse(tuple, atom) :: list|struct|atom
  def parse(response, name \\ nil) do
    case response do
      {:ok , ""} -> :ok
      {:ok, body} -> do_parse(body, name)
      {:error, error} -> error
    end
  end

  # Private -------------------------------------------------------------------

  defp do_parse(%{data: data}, name) do
    Enum.map(data, &(do_parse(&1, name)))
  end

  defp do_parse(data, name) do
    module_name = Atom.to_string(name)
    |> String.capitalize
    struct(:"Elixir.Vimeo.Resources.#{module_name}", data)
  end
end
