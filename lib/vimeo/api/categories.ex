# defmodule Vimeo.API.Categories do
#   @moduledoc """
#   Provides access to the `/categories` endpoints of the Vimeo API (for internal use).
#   """
#   import Vimeo.API.Base
#   import Vimeo.Parser

#   @doc """
#   Get a list of the top level categories.
#   """
#   def categories(token \\ :global, params \\ []) do
#     get("categories", token, params).data |> Enum.map(&(parse_category(&1)))
#   end

#   @doc """
#   Get a category.
#   """
#   def category(id, token \\ :global, params \\ []) do
#     get("categories/#{id}", token, params) |> parse_category
#   end

#   @doc """
#   Get a list of Channels related to a category.
#   """
#   def category_channels(id, token \\ :global, params \\ []) do
#     get("categories/#{id}/channels", token, params).data |> Enum.map(&(parse_channel(&1)))
#   end

#   @doc """
#   Get a list of Groups related to a category.
#   """
#   def category_groups(id, token \\ :global, params \\ []) do
#     get("categories/#{id}/groups", token, params).data |> Enum.map(&(parse_group(&1)))
#   end

#   @doc """
#   Get a list of videos related to a category.
#   """
#   def category_videos(id, token \\ :global, params \\ []) do
#     get("categories/#{id}/videos", token, params).data |> Enum.map(&(parse_video(&1)))
#   end
# end
