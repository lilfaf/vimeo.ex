defmodule Vimeo.GroupsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Vimeo.TestHelper

  doctest Vimeo.Me

  setup_all do
    TestHelper.setup
    Vimeo.configure
    :ok
  end

  test "should return a list of groups" do
    use_cassette "groups" do
      groups = Vimeo.Groups.all
      assert length(groups) == 25
    end
  end

  test "should return a group" do
    use_cassette "group" do
      group = Vimeo.Groups.get(342295)
      assert group.name == "foo"
    end
  end

  test "should create a new group" do
    use_cassette "group_create" do
      Vimeo.Groups.create(%{name: "foo", description: "foo desc"})

      group = Vimeo.Me.groups |> List.first
      assert group.name == "foo"
      assert group.description == "foo desc"
    end
  end

  test "should delete a channel" do
    use_cassette "group_delete" do
      Vimeo.Groups.delete(342299)
      assert length(Vimeo.Me.groups) == 0
    end
  end

  test "should return a list of users who joined a group" do
    use_cassette "group_users" do
      users = Vimeo.Groups.users(:musicvideo)
      assert length(users) == 25
    end
  end

  test "should return a list of videos for a group" do
    use_cassette "group_videos" do
      videos = Vimeo.Groups.videos(:musicvideo)
      assert length(videos) == 25
    end
  end

  test "should add a video to a group" do
    use_cassette "group_add_video" do
      Vimeo.Groups.add_video(342300, 18629165)

      video = Vimeo.Groups.video(342300, 18629165)
      assert video.name == "WINTERTOUR"
    end
  end

  # test "should remove a video from a group" do
  #   use_cassette "group_remove_video" do
  #     Vimeo.Groups.remove_video(342300, 18629165)
  #
  #     videos = Vimeo.Groups.videos(342300)
  #     assert length(videos) == 0
  #   end
  # end
end
