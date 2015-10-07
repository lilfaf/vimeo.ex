defmodule Vimeo.Config do

  @doc """
  Set OAuth configuration values and initialise the process
  """
  def configure(client_id, client_secret, redirect_uri) do
    start_link(%Vimeo.Model.ClientConfig{client_id: client_id, client_secret: client_secret, redirect_uri: redirect_uri})
    {:ok, []}
  end
  def configure do
    start_link(%Vimeo.Model.ClientConfig{
      client_id: Application.get_env(:vimeo, :vimeo_client_id) || System.get_env("VIMEO_CLIENT_ID"),
      client_secret: Application.get_env(:vimeo, :vimeo_client_secret) || System.get_env("VIMEO_CLIENT_SECRET"),
      redirect_uri: Application.get_env(:vimeo, :vimeo_redirect_uri) || System.get_env("VIMEO_REDIRECT_URI")
    })
    {:ok, []}
  end

  @doc """
  Set a global access token (associated with a user, rather than an application)
  """
  def configure(:global, token) do
    set(:access_token, token)
  end

  @doc """
  Get the configuration object
  """
  def get do
    Agent.get(__MODULE__, fn config -> config end)
  end

  # Set the configuration object
  defp set(key, value) do
    Agent.update(__MODULE__, fn config ->
      Map.update!(config, key, fn _ -> value end)
    end)
  end

  # Starts an agent with a configuration object as initial state
  defp start_link(value) do
    Agent.start_link(fn -> value end, name: __MODULE__)
  end
end
