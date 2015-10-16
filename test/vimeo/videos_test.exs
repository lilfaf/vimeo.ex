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

  test "should returns a list of videos" do
    use_cassette "videos" do
      videos = Vimeo.Videos.search(%{query: "wintertour"})
      assert length(videos) == 25
      assert length(List.first(videos).tags) == 5
    end
  end

  test "should return informations about a video" do
    use_cassette "video" do
      video = Vimeo.Videos.info(18629165)
      assert video.name == "WINTERTOUR"
    end
  end

  test "should update a video informations" do
    use_cassette "video_update" do
      video = Vimeo.Videos.update(18629165, %{name: "foobar"})
      assert video.name == "foobar"
    end
  end

  test "should delete a video" do
    use_cassette "video_delete" do
      assert Vimeo.Videos.delete(142675254) == :ok
      assert length(Vimeo.Me.videos) == 2
    end
  end

  test "should return a list of credits" do
    use_cassette "video_credits" do
      credits = Vimeo.Videos.credits(135340447)
      assert length(credits) == 2
    end
  end

  test "should return a single credit" do
    use_cassette "video_credit" do
      credit = Vimeo.Videos.credit(135340447, 145566262)
      assert credit.name == "foo"
    end
  end

  test "should create a credit on a video" do
    use_cassette "video_credit_create" do
      data = %{name: "foo", role: "bar", email: "foo@bar.com"}
      assert Vimeo.Videos.create_credit(18629165, data) == :ok

      credit = Vimeo.Videos.credits(18629165) |> List.first
      assert credit.name == "foo"
    end
  end

  test "should update a credit on a video" do
    use_cassette "video_credit_update" do
      credit = Vimeo.Videos.update_credit(18629165, 18759504, %{role: "foo"})
      assert credit.role == "foo"
    end
  end

  test "should return a list of videos related to a video" do
    use_cassette "video_related_videos" do
      videos = Vimeo.Videos.related_videos(35678857)
      assert length(videos) == 25
    end
  end
end
