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
    "me"
    |> API.get
    |> Parser.parse(:user)
  end

  @doc """
  Edit a single user.
  """
  def update(data) do
    "me"
    |> API.patch(data)
    |> Parser.parse
  end

  # Albums --------------------------------------------------------------------

  @doc """
  Get a list of a user's Albums.
  """
  def albums(params \\ %{}) do
    "me/albums"
    |> API.get(params)
    |> Parser.parse(:album)
  end

  @doc """
  Create an Album.
  """
  def create_album(data) do
    "me/albums"
    |> API.post(data)
    |> Parser.parse
  end

  @doc """
  Get info on an Album.
  """
  def album(id) do
    "me/albums/#{id}"
    |> API.get
    |> Parser.parse(:album)
  end

  @doc """
  Edit an Album.
  """
  def update_album(id, data) do
    "me/albums/#{id}"
    |> API.patch(data)
    |> Parser.parse
  end

  @doc """
  Delete an Album.
  """
  def delete_album(id) do
    "me/albums/#{id}"
    |> API.delete
    |> Parser.parse
  end

  @doc """
  Get the list of videos in an Album.
  """
  def album_videos(album_id, params \\ %{}) do
    "me/albums/#{album_id}/videos"
    |> API.get(params)
    |> Parser.parse(:video)
  end

  @doc """
  Get a single video from an Album.
  """
  def album_video(album_id, video_id) do
    "me/albums/#{album_id}/videos/#{video_id}"
    |> API.get
    |> Parser.parse(:video)
  end

  @doc """
  Add a video to an Album.
  """
  def add_album_video(album_id, video_id) do
    "me/albums/#{album_id}/videos/#{video_id}"
    |> API.put
    |> Parser.parse
  end

  @doc """
  Remove a video from an Album.
  """
  def remove_album_video(album_id, video_id) do
    "me/albums/#{album_id}/videos/#{video_id}"
    |> API.delete
    |> Parser.parse
  end

  # Appearances ---------------------------------------------------------------

  @doc """
  Get all videos that a user appears in.
  """
  def appearances(params \\ %{}) do
    "me/appearances"
    |> API.get(params)
    |> Parser.parse(:video)
  end

  # Channels ------------------------------------------------------------------

  @doc """
  Get a list of the Channels a user follows.
  """
  def channels(params \\ %{}) do
    "me/channels"
    |> API.get(params)
    |> Parser.parse(:channel)
  end

  @doc """
  Check if a user follows a Channel.
  """
  def channel?(channel_id) do
    case API.get("me/channels/#{channel_id}") do
      {:ok, _} -> true
      _ -> false
    end
  end

  @doc """
  Subscribe to a Channel.
  """
  def subscribe_channel(channel_id) do
    "me/channels/#{channel_id}"
    |> API.put
    |> Parser.parse
  end

  @doc """
  Unsubscribe from a Channel.
  """
  def unsubscribe_channel(channel_id) do
    "me/channels/#{channel_id}"
    |> API.delete
    |> Parser.parse
  end

  # Groups --------------------------------------------------------------------

  @doc """
  Get a list of the Groups a user has joined.
  """
  def groups(params \\ %{}) do
    "me/groups"
    |> API.get(params)
    |> Parser.parse(:group)
  end

  @doc """
  Check if a user joined a Group.
  """
  def group?(group_id) do
    case API.get("me/groups/#{group_id}") do
      {:ok, _} -> true
      _ -> false
    end
  end

  @doc """
  Join a Group.
  """
  def join_group(group_id) do
    "me/groups/#{group_id}"
    |> API.put
    |> Parser.parse
  end

  @doc """
  Leave a Group.
  """
  def leave_group(group_id) do
    "me/groups/#{group_id}"
    |> API.delete
    |> Parser.parse
  end

  # Feed ----------------------------------------------------------------------

  @doc """
  Get a list of the videos in your feed.
  """
  def feed(params \\ %{}) do
    "me/feed"
    |> API.get(params)
    |> Parser.parse(:video)
  end

  # Followers -----------------------------------------------------------------

  @doc """
  Get a list of the user's followers.
  """
  def followers(params \\ %{}) do
    "me/followers"
    |> API.get(params)
    |> Parser.parse(:user)
  end

  # Following -----------------------------------------------------------------

  @doc """
  Get a list of the users that a user is following.
  """
  def following(params \\ %{}) do
    "me/following"
    |> API.get(params)
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
    "me/following/#{user_id}"
    |> API.put
    |> Parser.parse
  end

  @doc """
  Unfollow a user.
  """
  def unfollow(user_id) do
    "me/following/#{user_id}"
    |> API.delete
    |> Parser.parse
  end

  # Likes ---------------------------------------------------------------------

  @doc """
  Get a list of videos that a user likes.
  """
  def likes(params \\ %{}) do
    "me/likes"
    |> API.get(params)
    |> Parser.parse(:video)
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
    "me/likes/#{video_id}"
    |> API.put
    |> Parser.parse
  end

  @doc """
  Unlike a video.
  """
  def unlike(video_id) do
    "me/likes/#{video_id}"
    |> API.delete
    |> Parser.parse
  end

  # Pictures ------------------------------------------------------------------

  @doc """
  Get a list of this user's portrait images.
  """
  def pictures do
    "me/pictures"
    |> API.get
    |> Parser.parse(:picture)
  end

  # @doc """
  # Create a new picture resource.
  # """
  # def create_picture(data) do
  # end

  @doc """
  Check if a user has a portrait.
  """
  def picture?(picture_id) do
    case API.get("me/pictures/#{picture_id}") do
      {:ok, _} -> true
      {:error, _} -> false
    end
  end

  @doc """
  Edit a portrait.
  """
  def update_picture(picture_id, params \\ %{}) do
    "me/pictures/#{picture_id}"
    |> API.patch(params)
    |> Parser.parse(:picture)
  end

  @doc """
  Remove a portrait from your portrait list.
  """
  def delete_picture(picture_id) do
    "me/pictures/#{picture_id}"
    |> API.delete
    |> Parser.parse
  end

  # Videos --------------------------------------------------------------------

  @doc """
  Get a list of videos uploaded by a user.
  """
  def videos(params \\ %{}) do
    "me/videos"
    |> API.get(params)
    |> Parser.parse(:video)
  end

  # @doc """
  # Begin the video upload process.
  # """
  # def upload_video(data, params \\ %{}) do
  # end

  @doc """
  Check if a user owns a clip.
  """
  def video?(video_id) do
    case API.get("me/videos/#{video_id}") do
      {:ok, _} -> true
      {:error, _} -> false
    end
  end
end
