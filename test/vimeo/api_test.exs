defmodule Vimeo.APITest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Vimeo.TestHelper

  setup_all do
    TestHelper.setup
    :ok
  end

  test "return an error when a bad access token is used" do
    Vimeo.configure(%{})
    use_cassette "oauth_exception" do
      error = %Vimeo.Error{
        code: 401,
        message: "You must provide a valid authenticated access token."
      }
      assert Vimeo.Me.info == error
    end
  end
end
