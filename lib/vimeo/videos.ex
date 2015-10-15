defmodule Vimeo.Videos do
  @moduledoc """
  Provides access to the `/videos` endpoints of the Vimeo API v3.
  """

  alias Vimeo.API
  alias Vimeo.Parser

  @doc """
  Search for videos.
  """
  def search(params \\ %{}) do
    API.get("videos", params)
    |> Parser.parse(:video)
  end
end