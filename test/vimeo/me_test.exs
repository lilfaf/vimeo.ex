defmodule Vimeo.MeTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Vimeo.TestHelper

  doctest Vimeo.Me

  setup_all do
    TestHelper.setup
    Vimeo.configure
    :ok
  end

  test "should return authenticated user informations" do
    use_cassette "my_info" do
      info = Vimeo.Me.info
      assert info.name == "louis larpin"
    end
  end

  test "should update authenticated user informations" do
    new_username = "foo"
    use_cassette "my_info_update" do
      assert Vimeo.Me.update(%{name: new_username})
      assert Vimeo.Me.info.name == new_username
    end
  end

  test "should return a list of albums for the authenticated user" do
    use_cassette "my_albums" do
      albums = Vimeo.Me.albums
      assert length(albums) == 1
    end
  end

  test "should return an album by id for the authenticated user" do
    use_cassette "my_album" do
      album = Vimeo.Me.album(3600066)
      assert album.name == "foo"
    end
  end

  test "should return followed channels for the authenticated user" do
    use_cassette "my_channels" do
      channels = Vimeo.Me.channels
      assert length(channels) == 1
    end
  end
end
