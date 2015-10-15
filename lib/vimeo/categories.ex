defmodule Vimeo.Categories do
  @moduledoc """
  Provides access to the `/categories` endpoints of the Vimeo API v3.
  """

  alias Vimeo.API
  alias Vimeo.Parser

  @doc """
  Get a list of the top level categories.
  """
  def all(params \\ %{}) do
    API.get("categories", params)
    |> Parser.parse(:category)
  end

  @doc """
  Get a category.
  """
  def get(id) do
    API.get("categories/#{id}")
    |> Parser.parse(:category)
  end

  @doc """
  Get a list of Channels related to a category.
  """
  def channels(category_id, params \\ %{}) do
    API.get("categories/#{category_id}/channels", params)
    |> Parser.parse(:channel)
  end

  @doc """
  Get a list of Groups related to a category.
  """
  def groups(category_id, params \\ %{}) do
    API.get("categories/#{category_id}/groups", params)
    |> Parser.parse(:group)
  end

  @doc """
  Get a list of videos related to a category.
  """
  def videos(category_id, params \\ %{}) do
    API.get("categories/#{category_id}/videos", params)
    |> Parser.parse(:video)
  end
end
