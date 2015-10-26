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
    "categories"
    |> API.get(params)
    |> Parser.parse(:category)
  end

  @doc """
  Get a category.
  """
  def get(id) do
    "categories/#{id}"
    |> API.get
    |> Parser.parse(:category)
  end

  @doc """
  Get a list of Channels related to a category.
  """
  def channels(category_id, params \\ %{}) do
    "categories/#{category_id}/channels"
    |> API.get(params)
    |> Parser.parse(:channel)
  end

  @doc """
  Get a list of Groups related to a category.
  """
  def groups(category_id, params \\ %{}) do
    "categories/#{category_id}/groups"
    |> API.get(params)
    |> Parser.parse(:group)
  end

  @doc """
  Get a list of videos related to a category.
  """
  def videos(category_id, params \\ %{}) do
    "categories/#{category_id}/videos"
    |> API.get(params)
    |> Parser.parse(:video)
  end
end
