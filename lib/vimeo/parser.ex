defmodule Vimeo.Parser do
  @moduledoc """
  """

  @doc """
  """
  def parse_user(object) do
    struct(Vimeo.Resources.User, object)
  end

  @doc """
  """
  def parse_category(object) do
    struct(Vimeo.Resources.Category, object)
  end

  @doc """
  """
  def parse_album(object) do
    struct(Vimeo.Resources.Album, object)
  end

  @doc """
  """
  def parse_channel(object) do
    struct(Vimeo.Resources.Channel, object)
  end

  @doc """
  """
  def parse_group(object) do
    struct(Vimeo.Resources.Group, object)
  end

  @doc """
  """
  def parse_video(object) do
    struct(Vimeo.Resources.Video, object)
  end
end




