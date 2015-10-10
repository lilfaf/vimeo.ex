# defmodule Vimeo.API.Channels do
#   @moduledoc """
#   Provides access to the `/channels` endpoints of the Vimeo API (for internal use).
#   """
#   import Vimeo.API.Base
#   import Vimeo.Parser

#   @doc """
#   Get a list of all Channels.
#   """
#   def channels(token \\ :global, params \\ []) do
#     get("channels", token, params).data |> Enum.map(&(parse_channel(&1)))
#   end

#   @doc """
#   Get a Channel.
#   """
#   def channel(id, token \\ :global, params \\ []) do
#     get("channels/#{id}", token, params) |> parse_channel
#   end

#   @doc """
#   Create a new Channel.
#   """
#   def create_channel(data, token \\ :global, params \\ []) do
#     post("channels", token, Poison.encode!(data), params)
#   end

#   @doc """
#   Edit a Channel's information.
#   """
#   def update_channel(id, data, token \\ :global, params \\ []) do
#     patch("channels/#{id}", token, Poison.encode!(data), params)
#   end

#   @doc """
#   Delete a Channel.
#   """
#   def delete_channel(id, token \\ :global) do
#     delete("channels/#{id}", token)
#   end

#   @doc """
#   Get a list of users who follow a Channel.
#   """
#   def channel_users(id, token \\ :global) do
#     get("channels/#{id}/users", token).data |> Enum.map(&(parse_user(&1)))
#   end

#   @doc """
#   Get a list of videos in a Channel.
#   """
#   def channel_videos(id, token \\ :global) do
#     get("channels/#{id}/videos", token).data |> Enum.map(&(parse_video(&1)))
#   end

#   @doc """
#   Check if this Channel contains a video.
#   """
#   def channel_video(channel_id, video_id, token \\ :global) do
#     get("channels/#{channel_id}/videos/#{video_id}", token) |> parse_video
#   end

#   @doc """
#   Add a video to a Channel.
#   """
#   def add_channel_video(channel_id, video_id, token \\ :global) do
#     put("channels/#{channel_id}/videos/#{video_id}", token)
#   end

#   @doc """
#   Remove a video from a Channel.
#   """
#   def remove_channel_video(channel_id, video_id, token \\ :global) do
#     delete("channels/#{channel_id}/videos/#{video_id}", token)
#   end
# end
