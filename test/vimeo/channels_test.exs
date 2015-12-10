defmodule Vimeo.ChannelsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Vimeo.TestHelper

  doctest Vimeo.Channels

  setup_all do
    TestHelper.setup
    Vimeo.configure
    :ok
  end

  test "should return a list of channels" do
    use_cassette "channels" do
      channels = Vimeo.Channels.all
      assert length(channels) == 25
    end
  end

  test "should return a channel for id" do
    use_cassette "channel" do
      channel = Vimeo.Channels.get(2981)
      assert channel.name == "Everything Animated"
    end
  end

  test "should create a new channel" do
    use_cassette "channel_create" do
      Vimeo.Channels.create(%{name: "foo", description: "foo desc"})

      channel = Vimeo.Me.channels |> List.first
      assert channel.name == "foo"
      assert channel.description == "foo desc"
    end
  end

  test "should update a channel's information" do
    use_cassette "channel_update" do
      Vimeo.Channels.update(999585, %{name: "bar", description: "bar desc"})

      channel = Vimeo.Channels.get(999585)
      assert channel.name == "bar"
      assert channel.description == "bar desc"
    end
  end

  test "should delete a channel" do
    use_cassette "channel_delete" do
      Vimeo.Channels.delete(999585)

      channels = Vimeo.Me.channels
      assert length(channels) == 0
    end
  end

  test "should return a list of users who follow a channel" do
    use_cassette "channel_users" do
      users = Vimeo.Channels.users(:themgoods)
      assert length(users) == 25
    end
  end

  test "should return a list of videos for a channel" do
    use_cassette "channel_videos" do
      videos = Vimeo.Channels.videos(:themgoods)
      assert length(videos) == 25
    end
  end

  test "should returns a video for a channel" do
    use_cassette "channel_video" do
      video = Vimeo.Channels.video(:themgoods, 141379107)
      assert video.duration == 54
    end
  end

  test "should add a video to a channel" do
    use_cassette "channel_add_video" do
      Vimeo.Channels.add_video(999587, 18629165)

      video = Vimeo.Channels.video(999587, 18629165)
      assert video.name == "WINTERTOUR"
    end
  end

  test "should remove a video from a channel" do
    use_cassette "channel_remove_video" do
      Vimeo.Channels.remove_video(999587, 18629165)

      videos = Vimeo.Channels.videos(999587)
      assert length(videos) == 0
    end
  end
end
