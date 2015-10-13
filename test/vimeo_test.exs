defmodule VimeoTest do
  use ExUnit.Case

  test "sets configuration at runtime" do
    config = %{client_id: "X", client_secret: "XX", access_token: "123"}
    Vimeo.configure(config.client_id, config.client_secret, config.access_token)

    assert Vimeo.config == config
    assert Vimeo.client_id == config.client_id
    assert Vimeo.client_secret == config.client_secret
    assert Vimeo.token == config.access_token
  end

  test "sets access token at runtime" do
    Vimeo.configure
    Vimeo.token("123")

    assert Vimeo.token == "123"
  end

  test "gets configuration from environment variables" do
    config = %{client_id: "XXX", client_secret: "XXXX", access_token: "XXXXX"}

    System.put_env "VIMEO_CLIENT_ID",     config.client_id
    System.put_env "VIMEO_CLIENT_SECRET", config.client_secret
    System.put_env "VIMEO_ACCESS_TOKEN",  config.access_token
    Vimeo.configure

    assert Vimeo.config == config
  end
end
