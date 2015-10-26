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
    "tags/#{id}"
    |> API.get
    |> Parser.parse(:tag)
  end

  @doc """
  Get a list of videos associated with a tag.
  """
  def videos(tag_id, params \\ %{}) do
    "tags/#{tag_id}/videos"
    |> API.get(params)
    |> Parser.parse(:video)
  end
end
