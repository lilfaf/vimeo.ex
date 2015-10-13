defmodule Vimeo.VideosTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Vimeo.TestHelper

  doctest Vimeo.Videos

  setup_all do
    TestHelper.setup
    Vimeo.configure
    :ok
  end

  test "should returns a a list of videos" do
    use_cassette "videos" do
      videos = Vimeo.Videos.search(%{query: "wintertour"})
      assert length(videos) == 25
      assert length(List.first(videos).tags) == 5
    end
  end
end
