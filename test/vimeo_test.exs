defmodule VimeoTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Vimeo

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes", "fixture/custom_cassettes")
    ExVCR.Config.filter_url_params(true)

    ExVCR.Config.filter_sensitive_data("client_id=.+", "<REMOVED>")
    ExVCR.Config.filter_sensitive_data("client_secret=.+", "<REMOVED>")

    Dotenv.load!
    Vimeo.configure
    :ok
  end

  test "gets current configuration" do
    config = Vimeo.Config.get
    assert config.client_id != nil
    assert config.client_secret != nil
    assert config.redirect_uri != nil
  end

  test "gets an access token, and test it's validity" do
    code = "XXXXXX"
    use_cassette "access_token" do
      token = Vimeo.get_token!(code: code)
      user = Vimeo.my_info(token.access_token)
      assert user.name == "louis larp"
    end
  end

  test "raise an exception when a bad access token is used" do
    use_cassette "oauth_exception" do
      assert_raise Vimeo.Error, fn -> Vimeo.my_info end
    end
  end


  # ------- Categories


  test "gets a list of categories (explicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")

    use_cassette "categories_auth_explicit" do
      categories = Vimeo.categories(token)
      assert length(categories) == 16
    end
  end

  test "gets a list of categories (implicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")
    Vimeo.configure(:global, token)

    use_cassette "categories_auth_implicit" do
      categories = Vimeo.categories()
      assert length(categories) == 16
    end
  end

  test "gets a category by id (explicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")

    use_cassette "category_auth_explicit" do
      category = Vimeo.category(:animation, token)
      assert category.name == "Animation"
    end
  end

  test "gets a category by id (implicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")
    Vimeo.configure(:global, token)

    use_cassette "category_auth_implicit" do
      category = Vimeo.category(:animation)
      assert category.name == "Animation"
    end
  end

  test "gets a list channels for category id (explicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")

    use_cassette "category_channels_auth_explicit" do
      channels = Vimeo.category_channels("Animation", token)
      assert length(channels) == 24
    end
  end

  test "gets a list channels for category id (implicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")
    Vimeo.configure(:global, token)

    use_cassette "category_channels_auth_implicit" do
      channels = Vimeo.category_channels("Animation")
      assert length(channels) == 24
    end
  end

  test "gets a list groups for category id (explicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")

    use_cassette "category_groups_auth_explicit" do
      groups = Vimeo.category_groups("Animation", token)
      assert length(groups) == 25
    end
  end

  test "gets a list groups for category id (implicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")
    Vimeo.configure(:global, token)

    use_cassette "category_groups_auth_implicit" do
      groups = Vimeo.category_groups("Animation")
      assert length(groups) == 25
    end
  end

  test "gets a list videos for category id (explicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")

    use_cassette "category_videos_auth_explicit" do
      videos = Vimeo.category_videos("Animation", token)
      assert length(videos) == 25
    end
  end

  test "gets a list videos for category id (implicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")
    Vimeo.configure(:global, token)

    use_cassette "category_videos_auth_implicit" do
      videos = Vimeo.category_videos("Animation")
      assert length(videos) == 25
    end
  end


  # ------- Channels

  test "gets a list channels (explicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")

    use_cassette "channels_auth_explicit" do
      channels = Vimeo.channels(token)
      assert length(channels) == 25
    end
  end

  test "gets a list channels (implicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")
    Vimeo.configure(:global, token)

    use_cassette "channels_auth_implicit" do
      channels = Vimeo.channels()
      assert length(channels) == 25
    end
  end

  test "gets a channel by id (explicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")

    use_cassette "channel_auth_explicit" do
      channel = Vimeo.channel(2981, token)
      assert channel.name == "Everything Animated"
    end
  end

  test "gets a channel by id (implicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")
    Vimeo.configure(:global, token)

    use_cassette "channel_auth_implicit" do
      channel = Vimeo.channel(2981)
      assert channel.name == "Everything Animated"
    end
  end


  # ------- Me


  test "updates user informations (explicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")
    new_username = "new_username_1"

    use_cassette "my_info_update_explicit" do
      assert Vimeo.my_info_update(%{name: new_username}, token) == :ok
      assert Vimeo.my_info(token).name == new_username
    end
  end

  test "updates user informations (implicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")
    Vimeo.configure(:global, token)
    new_username = "new_username_2"

    use_cassette "my_info_update_implicit" do
      assert Vimeo.my_info_update(%{name: new_username}) == :ok
      assert Vimeo.my_info(token).name == new_username
    end
  end

  test "gets a list of user albums (explicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")

    use_cassette "my_albums_explicit" do
      albums = Vimeo.my_albums(token)
      assert length(albums) == 1
    end
  end

  test "gets a list of user albums (implicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")
    Vimeo.configure(:global, token)

    use_cassette "my_albums_implicitly" do
      albums = Vimeo.my_albums
      assert length(albums) == 1
    end
  end

  test "gets user album by id (explicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")

    use_cassette "my_album_explicit" do
      album = Vimeo.my_album(3599116, token)
      assert album.name == "test"
    end
  end

  test "gets user album by id (implicitly authenticated)" do
    token = System.get_env("VIMEO_ACCESS_TOKEN")
    Vimeo.configure(:global, token)

    use_cassette "my_album_implicitly" do
      album = Vimeo.my_album(3599116)
      assert album.name == "test"
    end
  end
end
