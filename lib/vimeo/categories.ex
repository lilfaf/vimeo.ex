defmodule Vimeo.Categories do
  @moduledoc """
  Provides access to the `/categories` endpoints of the Vimeo API v3.
  """

  alias Vimeo.API
  alias Vimeo.Parser

  @doc """
  Get a list of the top level categories.
  """
  def all(params \\ []) do
    API.get("categories", params).data
    |> Enum.map(&(Parser.parse_category(&1)))
  end

  @doc """
  Get a category.
  """
  def get(id) do
    API.get("categories/#{id}")
    |> Parser.parse_category
  end

  @doc """
  Get a list of Channels related to a category.
  """
  def channels(id, params \\ []) do
    API.get("categories/#{id}/channels", params).data
    |> Enum.map(&(Parser.parse_channel(&1)))
  end

  @doc """
  Get a list of Groups related to a category.
  """
  def groups(id, params \\ []) do
    API.get("categories/#{id}/groups", params).data
    |> Enum.map(&(Parser.parse_group(&1)))
  end

  @doc """
  Get a list of videos related to a category.
  """
  def videos(id, params \\ []) do
    API.get("categories/#{id}/videos", params).data
    |> Enum.map(&(Parser.parse_video(&1)))
  end
end
