defmodule Vimeo.API.Channels do
  @moduledoc """
  Provides access to the `/channels` endpoints of the Vimeo API (for internal use).
  """
  import Vimeo.API.Base
  import Vimeo.Parser

  @doc """
  Get a list of all Channels.
  """
  def channels(token \\ :global, params \\ []) do
    get("channels", token, params).data |> Enum.map(&(parse_channel(&1)))
  end

  @doc """
  Get a Channel.
  """
  def channel(id, token \\ :global, params \\ []) do
    get("channels/#{id}", token, params) |> parse_channel
  end
end
