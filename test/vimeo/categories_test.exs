defmodule Vimeo.CategoriesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Vimeo.TestHelper

  doctest Vimeo.Categories

  setup_all do
    TestHelper.setup
    Vimeo.configure
    :ok
  end

  test "should return a list of categories" do
    use_cassette "categories" do
      categories = Vimeo.Categories.all
      assert length(categories) == 16
    end
  end

  test "should return a category for id" do
    use_cassette "category" do
      category = Vimeo.Categories.get(:animation)
      assert category.name == "Animation"
    end
  end

  test "should return a list of channels for category id" do
    use_cassette "category_channels" do
      channels = Vimeo.Categories.channels(:animation)
      assert length(channels) == 24
    end
  end

  test "should return a list of groups for category id" do
    use_cassette "category_groups" do
      groups = Vimeo.Categories.groups(:animation)
      assert length(groups) == 25
    end
  end

  test "should return a list of videos for category id" do
    use_cassette "category_videos" do
      videos = Vimeo.Categories.videos(:animation)
      assert length(videos) == 25
    end
  end
end
