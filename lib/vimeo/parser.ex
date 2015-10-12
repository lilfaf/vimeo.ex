defmodule Vimeo.Parser do
  @moduledoc """
  Defines parsing functionality to convert data Maps to the suitable module.
  """

  @doc """
  Parse data Map to struct.
  """
  @spec parse(map, atom) :: struct
  def parse(data, name) do
    module_name = Atom.to_string(name)
    |> String.capitalize
    struct(:"Elixir.Vimeo.Resources.#{module_name}", data)
  end
end
