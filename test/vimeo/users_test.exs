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

  test "should returns a a list of videos" do
    use_cassette "users" do
      users = Vimeo.Users.search(%{query: "foo"})
      List.first(users).name == "foo"
    end
  end
end
