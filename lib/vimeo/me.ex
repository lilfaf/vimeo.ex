defmodule Vimeo.Me do
  @moduledoc """
  Provides access to the `/me` endpoints of the Vimeo API v3.
  """

  alias Vimeo.API
  alias Vimeo.Parser

  # Informations --------------------------------------------------------------

  @doc """
  Get authenticated user informations.
  """
  def info do
    API.get("me") |> Parser.parse(:user)
  end

  @doc """
  Update authenticated user informations.
  """
  def update(data) do
    API.patch("me", data)
  end

  # Albums --------------------------------------------------------------------

  @doc """
  Get list of authenticated user albums.
  """
  def albums(params \\ %{}) do
    API.get("me/albums", params).data
    |> Enum.map(&(Parser.parse(&1, :album)))
  end

  @doc """
  Get info on authenticated user album.
  """
  def album(id) do
    API.get("me/albums/#{id}") |> Parser.parse(:album)
  end

  @doc """
  """
  def create_album(data) do
  end

  @doc """
  """
  def delete_album(id) do
  end

  @doc """
  """
  def album_videos(album_id) do
  end

  @doc """
  """
  def album_video(album_id, video_id) do
  end

  @doc """
  """
  def add_album_video(album_id, video_id) do
  end

  @doc """
  """
  def remove_album_video(album_id, video_id) do
  end

  # Channels ------------------------------------------------------------------

  @doc """
  Get a list of the channels the authenticated user follows
  """
  def channels(params \\ %{}) do
    API.get("me/channels", params).data
    |> Enum.map(&(Parser.parse(&1, :channel)))
  end

  # Groups --------------------------------------------------------------------

  @doc """
  Get a list of the groups the authenticated user follows
  """
  def groups(params \\ %{}) do
    API.get("me/groups", params).data
    |> Enum.map(&(Parser.parse(&1, :group)))
  end
end
