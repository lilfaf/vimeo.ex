defmodule Vimeo.Videos do
  @moduledoc """
  Provides access to the `/videos` endpoints of the Vimeo API v3.
  """

  alias Vimeo.API
  alias Vimeo.Parser

  # Search --------------------------------------------------------------------

  @doc """
  Search for videos.
  """
  def search(params \\ %{}) do
    "videos"
    |>API.get(params)
    |> Parser.parse(:video)
  end

  # Informations --------------------------------------------------------------

  @doc """
  Get a video.
  """
  def info(video_id) do
    "videos/#{video_id}"
    |> API.get
    |> Parser.parse(:video)
  end

  @doc """
  Edit video metadata.
  """
  def update(video_id, params \\ %{}) do
    "videos/#{video_id}"
    |>API.patch(params)
    |> Parser.parse(:video)
  end

  @doc """
  Delete a video.
  """
  def delete(video_id) do
    "videos/#{video_id}"
    |> API.delete
    |> Parser.parse
  end

  # Replace source file -------------------------------------------------------

  # @doc """
  # Get an upload ticket to replace this video file.
  # """
  # def replace(video_id, file) do
  # end

  # Credits -------------------------------------------------------------------

  @doc """
  Get a list of users credited on a video.
  """
  def credits(video_id, params \\ %{}) do
    "videos/#{video_id}/credits"
    |> API.get(params)
    |> Parser.parse(:credit)
  end

  @doc """
  Get a single credit.
  """
  def credit(video_id, credit_id) do
    "videos/#{video_id}/credits/#{credit_id}"
    |> API.get
    |> Parser.parse(:credit)
  end

  @doc """
  Add a credit to a video
  """
  def create_credit(video_id, data) do
    "videos/#{video_id}/credits"
    |> API.post(data)
    |> Parser.parse
  end

  @doc """
  Edit information about a single credit.
  """
  def update_credit(video_id, credit_id, data) do
    "videos/#{video_id}/credits/#{credit_id}"
    |> API.patch(data)
    |> Parser.parse(:credit)
  end

  # @doc """
  # Delete a credit on a video.
  # """
  # def delete_credit(video_id, credit_id) do
  #   "videos/#{video_id}/credits/#{credit_id}"
  #   |> API.delete
  #   |> Parser.parse
  # end

  # Related Videos ------------------------------------------------------------

  @doc """
  Get related videos.
  """
  def related_videos(video_id, params \\ %{}) do
    "videos/#{video_id}/videos"
    |> API.get(Map.put(params, :filter, "related"))
    |> Parser.parse(:video)
  end

  # Video Categories ----------------------------------------------------------

  @doc """
  Get a list of all categories this video is in.
  """
  def categories(video_id, params \\ %{}) do
    "videos/#{video_id}/categories"
    |> API.get(params)
    |> Parser.parse(:category)
  end

  # @doc """
  # Add up to 2 categories and 1 sub-category to a video.
  # This is mearly asuggestion, and does not ensure that the video will be added
  # to the category.
  # """
  # def add_category(video_id, data) do
  #   API.put("videos/#{video_id}/categories", data)
  # end

  # Comments ------------------------------------------------------------------

  @doc """
  Get comments on this video.
  """
  def comments(video_id, params \\ %{}) do
    "videos/#{video_id}/comments"
    |> API.get(params)
    |> Parser.parse(:comment)
  end

  @doc """
  Post a comment on the video.
  """
  def create_comment(video_id, text) do
    "videos/#{video_id}/comments"
    |> API.post(%{text: text})
    |> Parser.parse(:comment)
  end

  @doc """
  Check if a video has a specific comment.
  """
  def comment?(video_id, comment_id) do
    case API.get("videos/#{video_id}/comments/#{comment_id}") do
      {:ok, _} -> true
      {:error, _} -> false
    end
  end

  @doc """
  Edit an existing comment on a video
  """
  def update_comment(video_id, comment_id, text) do
    "videos/#{video_id}/comments/#{comment_id}"
    |> API.patch(%{text: text})
    |> Parser.parse(:comment)
  end

  @doc """
  Delete a comment from a video.
  """
  def delete_comment(video_id, comment_id) do
    "videos/#{video_id}/comments/#{comment_id}"
    |> API.delete
    |> Parser.parse
  end

  @doc """
  Gets replies to a comment on a video.
  """
  def comment_replies(video_id, comment_id, params \\ %{}) do
    "videos/#{video_id}/comments/#{comment_id}/replies"
    |> API.get(params)
    |> Parser.parse(:comment)
  end

  @doc """
  Post a reply to a comment on the video
  """
  def create_comment_reply(video_id, comment_id, text) do
    "videos/#{video_id}/comments/#{comment_id}/replies"
    |> API.post(%{text: text})
    |> Parser.parse(:comment)
  end

  # Pictures ------------------------------------------------------------------

  @doc """
  Get a list of this video's past and present pictures.
  """
  def pictures(video_id) do
    "videos/#{video_id}/pictures"
    |> API.get
    |> Parser.parse(:picture)
  end

  # @doc """
  # Add a picture resource to a video.
  # """
  # def create_picture(data, params \\ %{}) do
  # end

  @doc """
  Get a single picture resource for a video.
  """
  def picture(video_id, picture_id) do
    "videos/#{video_id}/pictures/#{picture_id}"
    |> API.get
    |> Parser.parse(:picture)
  end

  @doc """
  Modify an existing picture on a video.
  """
  def update_picture(video_id, picture_id, data) do
    "videos/#{video_id}/pictures/#{picture_id}"
    |> API.patch(data)
    |> Parser.parse(:picture)
  end

  @doc """
  Remove an existing picture from a video.
  """
  def delete_picture(video_id, picture_id) do
    "videos/#{video_id}/pictures/#{picture_id}"
    |> API.delete
    |> Parser.parse
  end

  # Likes ---------------------------------------------------------------------

  @doc """
  Get a list of the users who liked this video.
  """
  def likes(video_id, params \\ %{}) do
    "videos/#{video_id}/likes"
    |> API.get(params)
    |> Parser.parse(:user)
  end

  # Tags ----------------------------------------------------------------------

  @doc """
  List all of the tags on the video.
  """
  def tags(video_id) do
    "videos/#{video_id}/tags"
    |> API.get
    |> Parser.parse(:tag)
  end

  @doc """
  Check if a tag has been applied to a video.
  """
  def tag?(video_id, word) do
    case API.get("videos/#{video_id}/tags/#{word}") do
      {:ok, _} -> true
      {:error, _} -> false
    end
  end

  @doc """
  Tag a video.
  """
  def tag(video_id, word) do
    "videos/#{video_id}/tags/#{word}"
    |> API.put
    |> Parser.parse(:tag)
  end

  @doc """
  Remove the tag from this video.
  """
  def remove_tag(video_id, word) do
    "videos/#{video_id}/tags/#{word}"
    |> API.delete
    |> Parser.parse
  end

  # Users ---------------------------------------------------------------------

  @doc """
  Get all users that are allowed to see this video.
  """
  def users(video_id) do
    "videos/#{video_id}/privacy/users"
    |> API.get
    |> Parser.parse(:user)
  end

  @doc """
  Add a user to the allowed users list.
  """
  def add_user(video_id, user_id) do
    "videos/#{video_id}/privacy/users/#{user_id}"
    |> API.put
    |> Parser.parse
  end

  @doc """
  Remove a user from the allowed users list.
  """
  def remove_user(video_id, user_id) do
    "videos/#{video_id}/privacy/users/#{user_id}"
    |> API.delete
    |> Parser.parse
  end
end
