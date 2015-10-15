defmodule Vimeo.Users do
  @moduledoc """
  Provides access to the `/users` endpoints of the Vimeo API v3.
  """

  alias Vimeo.API
  alias Vimeo.Parser

  @doc """
  Search for users.
  """
  def search(params \\ %{}) do
    API.get("users", params)
    |> Parser.parse(:user)
  end
end
