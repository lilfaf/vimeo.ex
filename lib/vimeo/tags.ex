defmodule Vimeo.Tags do
  @moduledoc """
  Provides access to the `/tags` endpoints of the Vimeo API v3.
  """

  alias Vimeo.API
  alias Vimeo.Parser

  @doc """
  Get a Tag.
  """
  def get(id) do
    API.get("tags/#{id}")
    |> Parser.parse(:tag)
  end

  @doc """
  Get a list of videos associated with a tag.
  """
  def videos(tag_id, params \\ %{}) do
    API.get("tags/#{tag_id}/videos", params)
    |> Parser.parse(:video)
  end
end