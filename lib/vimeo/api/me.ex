defmodule Vimeo.API.Me do
  @moduledoc """
  Provides access to the `/me` endpoints of the Vimeo API (for internal use).
  """
  import Vimeo.API.Base
  import Vimeo.Parser

  @doc """
  Get authenticated user informations.
  """
  def my_info(token \\ :global) do
    get("me", token) |> parse_user
  end

  @doc """
  Get list of authenticated user albums.
  """
  def my_albums(token \\ :global) do
    get("me/albums", token).data |> Enum.map(&(parse_album(&1)))
  end

  @doc """
  Get info on authenticated user album.
  """
  def my_album(id, token \\ :global) do
    get("me/albums/#{id}", token) |> parse_album
  end

  @doc """
  Get a list of the channels the authenticated user follows
  """
  def my_channels(token \\ :global) do
    get("me/channels", token).data |> Enum.map(&(parse_channel(&1)))
  end

  @doc """
  Update authenticated user informations.
  """
  def update_profile(data, token \\ :global) do
    patch("me", token, Poison.encode!(data))
  end
end
