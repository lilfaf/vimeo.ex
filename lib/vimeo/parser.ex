defmodule Vimeo.Parser do

  def parse_user(object) do
    struct(Vimeo.Model.User, object)
  end

  def parse_category(object) do
    struct(Vimeo.Model.Category, object)
  end

  def parse_album(object) do
    struct(Vimeo.Model.Album, object)
  end

  def parse_channel(object) do
    struct(Vimeo.Model.Channel, object)
  end

  def parse_group(object) do
    struct(Vimeo.Model.Video, object)
  end

  def parse_video(object) do
    struct(Vimeo.Model.Video, object)
  end
end
