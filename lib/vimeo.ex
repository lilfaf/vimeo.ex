defmodule Vimeo do
  @moduledoc """
  This module provides access to the Vimeo API v3.
  """

  # Exception -----------------------------------------------------------------

  defmodule Error do
    @moduledoc """
    Define a vimeo error with an http code and a message.
    """
    defexception [:code, message: "Vimeo API client error"]
  end

  # Configuration -------------------------------------------------------------

  @doc """
  Initialise the process with `client_id`, `client_secret`
  and an optional `access_token`.
  """
  @spec configure(binary, binary, binary) :: atom
  def configure(id, secret, token \\ nil) do
    configure %{client_id: id, client_secret: secret, access_token: token}
  end

  @doc """
  Initialise the process with system environment variables
  `VIMEO_CLIENT_ID`, `VIMEO_CLIENT_SECRET` and `VIMEO_ACESS_TOKEN`.
  """
  @spec configure :: atom
  def configure do
    configure(get_env(:client_id),
              get_env(:client_secret),
              get_env(:access_token))
  end

  @doc """
  Initialise the process with a configuration Map.
  """
  @spec configure(map) :: atom
  def configure(config) when is_map(config), do: start_link(config)

  # Accessor methods ----------------------------------------------------------

  @doc """
  Returns global configuration Map.
  """
  @spec config :: map
  def config, do: get_config

  @doc """
  Returns the `client_id` from configuration.
  """
  @spec client_id :: binary
  def client_id, do: Map.get(config, :client_id)

  @doc """
  Returns the `client_secret` from configuration.
  """
  @spec client_secret :: binary
  def client_secret, do: Map.get(config, :client_secret)

  @doc """
  Returns the `access_tokens` from configuration.
  """
  @spec access_token :: binary
  def access_token, do: Map.get(config, :access_token)

  @doc """
  Sets or updates the `access_tokens` on configuration.
  """
  @spec access_token(binary) :: atom
  def access_token(token), do: set_config(:access_token, token)

  # Private -------------------------------------------------------------------

  defp start_link(config) do
    Agent.start_link(fn -> config end, name: __MODULE__)
  end

  defp get_config do
    Agent.get(__MODULE__, fn config -> config end)
  end

  defp set_config(key, value) do
    Agent.update(__MODULE__, fn config ->
      Map.update!(config, key, fn _ -> value end)
    end)
  end

  defp get_env(key, scope \\ :vimeo) do
    Application.get_env(scope, key)
    || "#{scope}_#{key}" |> String.upcase |> System.get_env
  end
end
