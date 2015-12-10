defmodule Vimeo.UsersTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Vimeo.TestHelper

  doctest Vimeo.Users

  setup_all do
    TestHelper.setup
    Vimeo.configure
    :ok
  end

  test "should returns a list of users" do
    use_cassette "users" do
      users = Vimeo.Users.search(%{query: "foo"})
      List.first(users).name == "foo"
    end
  end

  test "should return a user" do
    use_cassette "user" do
      user = Vimeo.Users.info(4443526)
      assert user.name == "foo"
    end
  end

  test "should update user informations" do
    use_cassette "user_update" do
      user = Vimeo.Users.update(4443526, %{name: "bar"})
      assert user.name == "bar"
    end
  end

  test "should return a list of user's albums" do
    use_cassette "user_albums" do
      albums = Vimeo.Users.albums(4443526)
      assert length(albums) == 1
      assert List.first(albums).name == "foo"
    end
  end

  test "should create an album for a user" do
    use_cassette "user_albums_create" do
      params = %{name: "bar", description: "bar desc"}
      album = Vimeo.Users.create_album(4443526, params)
      assert album.name == "bar"
      assert album.description == "bar desc"
    end
  end

  test "should return a user's album" do
    use_cassette "user_album" do
      album = Vimeo.Users.album(4443526, 3694573)
      assert album.name == "foo"
    end
  end

  test "should update a user's album" do
    use_cassette "user_album_update" do
      album = Vimeo.Users.update_album(4443526, 3694573, %{name: "foobar"})
      assert album.name == "foobar"
    end
  end

  test "should delete a user's album" do
    use_cassette "user_album_delete" do
      assert Vimeo.Users.delete_album(4443526, 3694639) == :ok
      assert length(Vimeo.Users.albums(4443526)) == 1
    end
  end

  test "should return a list of videos for a user's album" do
    use_cassette "user_album_videos" do
      videos = Vimeo.Users.album_videos(4443526, 3694573)
      assert length(videos) == 1
      assert List.first(videos).name == "WINTERTOUR"
    end
  end

  test "should check if a user's album contains a video" do
    use_cassette "user_album_video?" do
      refute Vimeo.Users.album_video?(4443526, 3694573, 123)
      assert Vimeo.Users.album_video?(4443526, 3694573, 18629165)
    end
  end

  test "should add a video to a user's album" do
    use_cassette "user_album_add_video" do
      assert Vimeo.Users.add_album_video(4443526, 3694573, 135340447) == :ok
      assert length(Vimeo.Users.album_videos(4443526, 3694573)) == 2
    end
  end

  test "should remove a video from a user's album" do
    use_cassette "user_album_remove_video" do
      assert Vimeo.Users.remove_album_video(4443526, 3694573, 135340447) == :ok
      assert length(Vimeo.Users.album_videos(4443526, 3694573)) == 1
    end
  end

  test "should return a list of videos a user appears in" do
    use_cassette "user_appearances" do
      videos = Vimeo.Users.appearances(4443526)
      assert length(videos) == 1
    end
  end

  test "should return a list of channels a user follows" do
    use_cassette "user_channels" do
      channels = Vimeo.Users.channels(4443526)
      assert length(channels) == 1
    end
  end

  test "should subscribe user to a channel" do
    use_cassette "user_channels_subscribe" do
      assert Vimeo.Users.subscribe_channel(4443526, :xsjado) == :ok
      assert length(Vimeo.Users.channels(4443526)) == 2
    end
  end

  test "should check if a user follows a channel" do
    use_cassette "user_channel?" do
      refute Vimeo.Users.channel?(4443526, :foobar)
      assert Vimeo.Users.channel?(4443526, :xsjado)
    end
  end

  test "should unsubscribe user from a channel" do
    use_cassette "user_channels_unsubscribe" do
      assert Vimeo.Users.unsubscribe_channel(4443526, :xsjado) == :ok
      assert length(Vimeo.Users.channels(4443526)) == 1
    end
  end

  test "should return a list of groups a user joined" do
    use_cassette "user_groups" do
      groups = Vimeo.Users.groups(4443526)
      assert length(groups) == 1
    end
  end

  test "should join user to a group" do
    use_cassette "user_groups_join" do
      assert Vimeo.Users.join_group(4443526, :hdxs) == :ok
      assert length(Vimeo.Users.groups(4443526)) == 2
    end
  end

  test "should check if a user joined a group" do
    use_cassette "user_group?" do
      refute Vimeo.Users.group?(4443526, :foobar)
      assert Vimeo.Users.group?(4443526, :hdxs)
    end
  end

  test "should remove user from a group" do
    use_cassette "user_groups_leave" do
      assert Vimeo.Users.leave_group(4443526, :hdxs) == :ok
      assert length(Vimeo.Users.groups(4443526)) == 1
    end
  end

  test "should return a list of videos from a user feed" do
    use_cassette "user_feed" do
      videos = Vimeo.Users.feed(4443526)
      assert length(videos) == 25
      assert List.first(videos).name == "Bad Guy #2"
    end
  end

  test "should return a list user's followers" do
    use_cassette "user_followers" do
      users = Vimeo.Users.followers(4443526)
      assert length(users) == 2
      assert List.last(users).name == "ARTSN Video (Arsène Jurman)"
    end
  end

  test "should return a list of users that a user is following" do
    use_cassette "user_following" do
      users = Vimeo.Users.following(4443526)
      assert length(users) == 1
      assert List.first(users).name == "ARTSN Video (Arsène Jurman)"
    end
  end

  test "should check if a user follows another user" do
    use_cassette "user_following?" do
      refute Vimeo.Users.following?(4443526, :foobar)
      assert Vimeo.Users.following?(4443526, :artsnvideo)
    end
  end

  test "should follow a user" do
    use_cassette "user_follow" do
      assert Vimeo.Users.follow(4443526, :themgoods1) == :ok
      assert length(Vimeo.Users.following(4443526)) == 2
    end
  end

  test "should unfollow a user" do
    use_cassette "user_unfollow" do
      assert Vimeo.Users.unfollow(4443526, :themgoods1) == :ok
      assert length(Vimeo.Users.following(4443526)) == 1
    end
  end

  test "should retrun a list of videos a user likes" do
    use_cassette "user_likes" do
      videos = Vimeo.Users.likes(4443526)
      assert length(videos) == 1
      assert List.first(videos).duration == 122
    end
  end

  test "should like a video for a user" do
    use_cassette "user_like" do
      assert Vimeo.Users.like(4443526, 96652365) == :ok
      assert length(Vimeo.Me.likes) == 2
    end
  end

  test "should check if a user likes a video" do
    use_cassette "user_like?" do
      refute Vimeo.Users.like?(4443526, 123)
      assert Vimeo.Users.like?(4443526, 96652365)
    end
  end

  test "should unlike a video for a user" do
    use_cassette "user_unlike" do
      assert Vimeo.Users.unlike(4443526, 96652365) == :ok
      assert length(Vimeo.Users.likes(4443526)) == 1
    end
  end

  test "should return a list of user's pictures" do
    use_cassette "user_pictures" do
      pictures = Vimeo.Users.pictures(4443526)
      assert length(pictures) == 1
      assert List.first(pictures).active
    end
  end

  # TODO test picture upload here

  test "should check if a user has a picture" do
    use_cassette "user_picture?" do
      refute Vimeo.Users.picture?(4443526, 123)
      assert Vimeo.Users.picture?(4443526, 10245674)
    end
  end

  test "should update a picture" do
    use_cassette "user_picture_update" do
      picture = Vimeo.Users.update_picture(4443526, 10739219, %{active: true})
      assert picture.active
    end
  end

  test "should delete a picture" do
    use_cassette "user_picture_delete" do
      assert Vimeo.Users.delete_picture(4443526, 10739219) == :ok
      assert length(Vimeo.Users.pictures(4443526)) == 1
    end
  end

  test "should return a list of videos" do
    use_cassette "user_videos" do
      videos = Vimeo.Users.videos(4443526)
      assert length(videos) == 2
    end
  end

  # TODO test video upload here

  test "should check if a user owns a video" do
    use_cassette "user_video?" do
      refute Vimeo.Users.video?(4443526, 123)
      assert Vimeo.Users.video?(4443526, 18629165)
    end
  end
end
