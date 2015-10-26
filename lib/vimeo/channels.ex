defmodule Vimeo.Channels do
  @moduledoc """
  Provides access to the `/me` endpoints of the Vimeo API v3.
  """

  alias Vimeo.API
  alias Vimeo.Parser

  @doc """
  Get a list of all Channels.
  """
  def all(params \\ %{}) do
    "channels"
    |> API.get(params)
    |> Parser.parse(:channel)
  end

  @doc """
  Get a Channel.
  """
  def get(id) do
    "channels/#{id}"
    |> API.get
    |> Parser.parse(:channel)
  end

  @doc """
  Create a new Channel.
  """
  def create(data) do
    API.post("channels", data)
  end

  @doc """
  Edit a Channel's information.
  """
  def update(id, data) do
    API.patch("channels/#{id}", data)
  end

  @doc """
  Delete a Channel.
  """
  def delete(id) do
    API.delete("channels/#{id}")
  end

  @doc """
  Get a list of users who follow a Channel.
  """
  def users(channel_id, params \\ %{}) do
    "channels/#{channel_id}/users"
    |> API.get(params)
    |> Parser.parse(:user)
  end

  @doc """
  Get a list of videos in a Channel.
  """
  def videos(channel_id, params \\ %{}) do
    "channels/#{channel_id}/videos"
    |> API.get(params)
    |> Parser.parse(:video)
  end

  @doc """
  Check if this Channel contains a video.
  """
  def video(channel_id, video_id) do
    "channels/#{channel_id}/videos/#{video_id}"
    |> API.get
    |> Parser.parse(:video)
  end

  @doc """
  Add a video to a Channel.
  """
  def add_video(channel_id, video_id) do
    API.put("channels/#{channel_id}/videos/#{video_id}")
  end

  @doc """
  Remove a video from a Channel.
  """
  def remove_video(channel_id, video_id) do
    API.delete("channels/#{channel_id}/videos/#{video_id}")
  end
end
