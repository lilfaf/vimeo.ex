defmodule Vimeo.Groups do
  @moduledoc """
  Provides access to the `/groups` endpoints of the Vimeo API v3.
  """

  alias Vimeo.API
  alias Vimeo.Parser

  @doc """
  Get a list of all Groups.
  """
  def all(params \\ %{}) do
    "groups"
    |> API.get(params)
    |> Parser.parse(:group)
  end

  @doc """
  Get a Group.
  """
  def get(id) do
    "groups/#{id}"
    |> API.get
    |> Parser.parse(:group)
  end

  @doc """
  Create a new Group.
  """
  def create(data) do
    API.post("groups", data)
  end

  @doc """
  Delete a Group.
  """
  def delete(id) do
    API.delete("groups/#{id}")
  end

  @doc """
  Get a list of users that joined a Group.
  """
  def users(id, params \\ %{}) do
    "groups/#{id}/users"
    |> API.get(params)
    |> Parser.parse(:user)
  end

  @doc """
  Get a list of videos in a Group.
  """
  def videos(group_id, params \\ %{}) do
    "groups/#{group_id}/videos"
    |> API.get(params)
    |> Parser.parse(:video)
  end

  @doc """
  Check if a Group has a video.
  """
  def video(group_id, video_id) do
    "groups/#{group_id}/videos/#{video_id}"
    |> API.get
    |> Parser.parse(:video)
  end

  @doc """
  Add a video to a Group.
  """
  def add_video(group_id, video_id) do
    API.put("groups/#{group_id}/videos/#{video_id}")
  end

  @doc """
  Remove a video from a Group.
  """
  def remove_video(group_id, video_id) do
    API.delete("groups/#{group_id}/videos/#{video_id}")
  end
end
