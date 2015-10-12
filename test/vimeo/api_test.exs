defmodule Vimeo.APITest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Vimeo.TestHelper

  setup_all do
    TestHelper.setup
    :ok
  end

  test "raise an exception when a bad access token is used" do
    Vimeo.configure(%{})
    use_cassette "oauth_exception" do
      assert_raise Vimeo.Error, fn -> Vimeo.Me.info end
    end
  end
end
