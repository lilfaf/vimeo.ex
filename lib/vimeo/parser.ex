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
      {:ok, body} -> do_parse(body, name)
      {:error, error} -> error
    end
  end

  # Private -------------------------------------------------------------------

  defp do_parse("", _), do: :ok

  defp do_parse(nil, _), do: nil

  defp do_parse(%{data: data}, name) do
    Enum.map(data, &(do_parse(&1, name)))
  end

  defp do_parse(data, :feed), do: do_parse(data.clip, :video)

  defp do_parse(%{__struct__: _, user: user} = resource, :user) do
    %{resource | user: do_parse(user, :user)}
  end

  defp do_parse(%{__struct__: _, tags: nil} = resource, :tags), do: resource

  defp do_parse(%{__struct__: _, tags: tags} = resource, :tags) do
    %{resource | tags: Enum.map(tags, &(do_parse(&1, :tag)))}
  end

  defp do_parse(%{__struct__: _, pictures: pictures} = resource, :pictures) do
    %{resource | pictures: do_parse(pictures, :picture)}
  end

  defp do_parse(%{} = data, name) do
    resource = struct(resource_module(name), data)

    Enum.reduce([:user, :tags, :pictures], resource, fn(key, resource) ->
      if Map.has_key?(resource, key), do: do_parse(resource, key), else: resource
    end)
  end

  defp resource_module(name) do
    module_name =
      name
      |> Atom.to_string
      |> String.capitalize
      :"Elixir.Vimeo.Resources.#{module_name}"
  end
end

