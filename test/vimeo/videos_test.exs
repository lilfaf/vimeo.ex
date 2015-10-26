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

      credit = List.first(Vimeo.Videos.credits(18629165))
      assert credit.name == "foo"
    end
  end

  test "should update a credit on a video" do
    use_cassette "video_credit_update" do
      credit = Vimeo.Videos.update_credit(18629165, 18759504, %{role: "foo"})
      assert credit.role == "foo"
    end
  end

  # test "should delete a credit on a video" do
  #   use_cassette "video_credit_delete" do
  #     assert Vimeo.Videos.delete_credit(18629165, 146881376) == :ok
  #     assert length(Vimeo.Videos.credits(18629165)) == 1
  #   end
  # end

  test "should return a list of videos related to a video" do
    use_cassette "video_related_videos" do
      videos = Vimeo.Videos.related_videos(35678857)
      assert length(videos) == 25
    end
  end

  test "should return a list of categories for a video" do
    use_cassette "video_categories" do
      categories = Vimeo.Videos.categories(139168608)
      assert length(categories) == 3
      assert List.first(categories).name == "Sports"
    end
  end

  test "should return a list of comments for a video" do
    use_cassette "video_comments" do
      comments = Vimeo.Videos.comments(96652365)
      assert length(comments) == 4
    end
  end

  test "should create a comment for a video" do
    use_cassette "video_comment_create" do
      text = "Hello from seshook!"
      comment = Vimeo.Videos.create_comment(96652365, text)
      assert comment.text == text
    end
  end

  test "should check if a video has a comment" do
    use_cassette "video_comment?" do
      refute Vimeo.Videos.comment?(96652365, 123)
      assert Vimeo.Videos.comment?(96652365, 13864877)
    end
  end

  test "should update a comment for a video" do
    use_cassette "video_comment_update" do
      new_text = "Je suis seshook!"
      comment = Vimeo.Videos.update_comment(96652365, 13866510, new_text)
      assert comment.text == new_text
    end
  end

  test "should delete a comment on a video" do
    use_cassette "video_comment_delete" do
      assert Vimeo.Videos.delete_comment(96652365, 13864877) == :ok
      refute Vimeo.Videos.comment?(96652365, 13864877)
    end
  end

  test "should returns replies on a comment" do
    use_cassette "video_comment_replies" do
      comments = Vimeo.Videos.comment_replies(96652365, 11674895)
      assert length(comments) == 1
      assert List.first(comments).text == "Agree !"
    end
  end

  test "should create a replie on a comment" do
    use_cassette "video_comment_create_reply" do
      text = "Agree again !"
      comment = Vimeo.Videos.create_comment_reply(96652365, 11674895, text)
      assert comment.text == text
    end
  end

  test "should return a list of pictures for a video" do
    use_cassette "video_pictures" do
      pictures = Vimeo.Videos.pictures(96652365)
      assert length(pictures) == 1
    end
  end

  test "should return info about a picture for a video" do
    use_cassette "video_picture" do
      picture = Vimeo.Videos.picture(96652365, 476766449)
      assert picture.active
    end
  end

  test "should update a picture for a video mark it as active" do
    use_cassette "video_picture_update" do
      params = %{active: true}
      picture = Vimeo.Videos.update_picture(18629165, 117328271, params)
      assert picture.active
    end
  end

  test "should delete a picture for a video" do
    use_cassette "video_picture_delete" do
      assert Vimeo.Videos.delete_picture(18629165, 540074942) == :ok
      assert length(Vimeo.Videos.pictures(18629165)) == 9
    end
  end

  test "should return a list of users who like a video" do
    use_cassette "video_likes" do
      users = Vimeo.Videos.likes(96652365)
      assert length(users) == 25
      assert List.first(users).name == "foo"
    end
  end

  test "should return a list of tags for a video" do
    use_cassette "video_tags" do
      tags = Vimeo.Videos.tags(96652365)
      assert length(tags) == 13
    end
  end

  test "should check if a video has a tag" do
    use_cassette "video_tag?" do
      refute Vimeo.Videos.tag?(96652365, "hello")
      assert Vimeo.Videos.tag?(96652365, "lyon")
    end
  end

  test "should create a tag for a video" do
    use_cassette "video_tag" do
      tag = Vimeo.Videos.tag(18629165, "friends")
      assert tag.name == "friends"
    end
  end

  test "should remove a tag for a video" do
    use_cassette "video_tag_remove" do
      assert Vimeo.Videos.remove_tag(18629165, "friends") == :ok
      assert length(Vimeo.Videos.tags(18629165)) == 3
    end
  end

  test "should return a list of users allowed to see a video" do
    use_cassette "video_users" do
      users = Vimeo.Videos.users(18629165)
      assert length(users) == 1
      assert List.first(users).name == "ARTSN Video (Arsène Jurman)"
    end
  end

  test "should add a user to the allowed users list for a video" do
    use_cassette "video_add_user" do
      assert Vimeo.Videos.add_user(18629165, :artsnvideo) == :ok
      assert length(Vimeo.Videos.users(18629165)) == 1
    end
  end

  test "should remove a user from the allowed users list for a video" do
    use_cassette "video_remove_user" do
      assert Vimeo.Videos.remove_user(18629165, :artsnvideo) == :ok
      assert length(Vimeo.Videos.users(18629165)) == 0
    end
  end
end
