defmodule Vimeo.Me do
  @moduledoc """
  Provides access to the `/me` endpoints of the Vimeo API v3.
  """

  alias Vimeo.API
  alias Vimeo.Parser

  # Informations --------------------------------------------------------------

  @doc """
  Get a user.
  """
  def info do
    API.get("me")
    |> Parser.parse(:user)
  end

  @doc """
  Edit a single user.
  """
  def update(data) do
    API.patch("me", data)
  end

  # Albums --------------------------------------------------------------------

  @doc """
  Get a list of a user's Albums.
  """
  def albums(params \\ %{}) do
    API.get("me/albums", params)
    |> Parser.parse(:album)
  end

  @doc """
  Create an Album.
  """
  def create_album(data) do
    API.post("me/albums", data)
  end

  @doc """
  Get info on an Album.
  """
  def album(id) do
    API.get("me/albums/#{id}")
    |> Parser.parse(:album)
  end

  @doc """
  Edit an Album.
  """
  def update_album(id, data) do
    API.patch("me/albums/#{id}", data)
  end

  @doc """
  Delete an Album.
  """
  def delete_album(id) do
    API.delete("me/albums/#{id}")
  end

  @doc """
  Get the list of videos in an Album.
  """
  def album_videos(album_id, params \\ %{}) do
    API.get("me/albums/#{album_id}/videos", params)
    |> Parser.parse(:video)
  end

  @doc """
  Get a single video from an Album.
  """
  def album_video(album_id, video_id) do
    API.get("me/albums/#{album_id}/videos/#{video_id}")
    |> Parser.parse(:video)
  end

  @doc """
  Add a video to an Album.
  """
  def add_album_video(album_id, video_id) do
    API.put("me/albums/#{album_id}/videos/#{video_id}")
  end

  @doc """
  Remove a video from an Album.
  """
  def remove_album_video(album_id, video_id) do
    API.delete("me/albums/#{album_id}/videos/#{video_id}")
  end

  # Appearances ---------------------------------------------------------------

  @doc """
  Get all videos that a user appears in.
  """
  def appearances(params \\ %{}) do
    API.get("me/appearances", params)
    |> Parser.parse(:video)
  end

  # Channels ------------------------------------------------------------------

  @doc """
  Get a list of the Channels a user follows.
  """
  def channels(params \\ %{}) do
    API.get("me/channels", params)
    |> Parser.parse(:channel)
  end

  @doc """
  Check if a user follows a Channel.
  """
  def channel?(id) do
    case API.get("me/channels/#{id}") do
      {:ok, _} -> true
      _ -> false
    end
  end

  @doc """
  Subscribe to a Channel.
  """
  def subscribe_channel(id) do
    API.put("me/channels/#{id}")
    |> Parser.parse
  end

  @doc """
  Unsubscribe from a Channel.
  """
  def unsubscribe_channel(id) do
    API.delete("me/channels/#{id}")
    |> Parser.parse
  end

  # Groups --------------------------------------------------------------------

  @doc """
  Get a list of the Groups a user has joined.
  """
  def groups(params \\ %{}) do
    API.get("me/groups", params)
    |> Parser.parse(:group)
  end

  @doc """
  Check if a user joined a Group.
  """
  def group?(id) do
    case API.get("me/groups/#{id}") do
      {:ok, _} -> true
      _ -> false
    end
  end

  @doc """
  Join a Group.
  """
  def join_group(id) do
    API.put("me/groups/#{id}")
    |> Parser.parse
  end

  @doc """
  Leave a Group.
  """
  def leave_group(id) do
    API.delete("me/groups/#{id}")
    |> Parser.parse
  end

  # Feed ----------------------------------------------------------------------

  @doc """
  Get a list of the videos in your feed.
  """
  def feed(params \\ %{}) do
    API.get("me/feed", params)
    |> Parser.parse(:video)
  end

  # Followers -----------------------------------------------------------------

  @doc """
  Get a list of the user's followers.
  """
  def followers(params \\ %{}) do
    API.get("me/followers", params)
    |> Parser.parse(:user)
  end

  # Following -----------------------------------------------------------------

  @doc """
  Get a list of the users that a user is following.
  """
  def following(params \\ %{}) do
    API.get("me/following", params)
    |> Parser.parse(:user)
  end

  @doc """
  Check if a user follows another user.
  """
  def following?(user_id) do
    case API.get("me/following/#{user_id}") do
      {:ok, _} -> true
      _ -> false
    end
  end

  @doc """
  Follow a user.
  """
  def follow(user_id) do
    API.put("me/following/#{user_id}")
    |> Parser.parse
  end

  @doc """
  Unfollow a user.
  """
  def unfollow(user_id) do
    API.delete("me/following/#{user_id}")
    |> Parser.parse
  end

  # Likes ---------------------------------------------------------------------

  @doc """
  Get a list of videos that a user likes.
  """
  def likes(params \\ %{}) do
  end

  @doc """
  Check if a user likes a video.
  """
  def like?(video_id) do
    case API.get("me/likes/#{video_id}") do
      {:ok, _} -> true
      _ -> false
    end
  end

  @doc """
  Like a video.
  """
  def like(video_id) do
  end

  @doc """
  Unlike a video.
  """
  def unlike(video_id) do
  end

  # Pictures ------------------------------------------------------------------

  @doc """
  Get a list of this user's portrait images.
  """
  def pictures(params \\ %{}) do
  end

  @doc """
  Create a new picture resource.
  """
  def create_picture(data) do
  end

  @doc """
  Check if a user has a portrait.
  """
  def picture?(picture_id) do
  end

  @doc """
  Edit a portrait.
  """
  def update_picture(picture_id) do
  end

  @doc """
  Remove a portrait from your portrait list.
  """
  def delete_picture(picture_id) do
  end
end
