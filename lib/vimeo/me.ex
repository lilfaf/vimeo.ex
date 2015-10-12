defmodule Vimeo.Me do
  @moduledoc """
  Provides access to the `/me` endpoints of the Vimeo API v3.
  """

  alias Vimeo.API
  alias Vimeo.Parser

  @doc """
  Get authenticated user informations.
  """
  def info do
    API.get("me") |> Parser.parse_user
  end

  @doc """
  Update authenticated user informations.
  """
  def update(data) do
    API.patch("me", data)
  end

  @doc """
  Get list of authenticated user albums.
  """
  def albums(params \\ []) do
    API.get("me/albums", params).data |> Enum.map(&(Parser.parse_album(&1)))
  end

  @doc """
  Get info on authenticated user album.
  """
  def album(id) do
    API.get("me/albums/#{id}") |> Parser.parse_album
  end

  @doc """
  Get a list of the channels the authenticated user follows
  """
  def channels(params \\ []) do
    API.get("me/channels", params).data |> Enum.map(&(Parser.parse_channel(&1)))
  end
end
