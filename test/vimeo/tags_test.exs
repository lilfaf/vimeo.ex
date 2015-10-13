defmodule Vimeo.TagsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Vimeo.TestHelper

  doctest Vimeo.Tags

  setup_all do
    TestHelper.setup
    Vimeo.configure
    :ok
  end

  test "should return a tag for id" do
    use_cassette "tag" do
      tag = Vimeo.Tags.get(:party)
      assert tag.name == "party"
    end
  end

  test "should returns a video for a channel" do
    use_cassette "tag_videos" do
      videos = Vimeo.Tags.videos(:party)
      assert length(videos) == 25
    end
  end
end
