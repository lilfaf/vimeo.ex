defmodule Vimeo do
  @moduledoc """
    This module provides access to the Vimeo API v3
  """

  # Exception -----------------------------------------------------------------

  defmodule Error do
    @moduledoc """
      Define a vimeo error with an http code and a message

      ## TODO
        Description Vimeo errors codes
    """
    defexception [:code, :message]
  end

  # Configuration -------------------------------------------------------------

  @doc """
    # TODO
  """
  @spec configure(binary, binary, binary) :: atom
  def configure(id, secret, token \\ nil) do
    configure %{client_id: id, client_secret: secret, token: token}
  end

  @doc """
    # TODO
  """
  def configure do
    configure(env(:client_id), env(:client_secret), env(:access_token))
  end

  @doc """
    # TODO
  """
  @spec configure(map) :: atom
  def configure(config) when is_map(config), do: start_link(config)

  # Accessor methods ----------------------------------------------------------

  @doc """
    # TODO
  """
  @spec env(atom) :: binary
  def env(key), do: get_env(key)

  @doc """
    # TODO
  """
  def config, do: get_config

  @doc """
    # TODO
  """
  def client_id, do: config[:client_id]

  @doc """
    # TODO
  """
  def client_secret, do: config[:client_secret]

  @doc """
    # TODO
  """
  def token, do: config[:token]

  @doc """
    # TODO
  """
  @spec token(binary) :: atom
  def token(token), do: set_config(:token, token)

  # Private -------------------------------------------------------------------

  @spec start_link(map) :: atom
  defp start_link(config) do
    Agent.start_link(fn -> config end, name: __MODULE__)
  end

  @spec get_config :: map
  defp get_config do
    Agent.get(__MODULE__, fn config -> config end)
  end

  @spec set_config(atom, binary) :: :atom
  defp set_config(key, value) do
    Agent.update(__MODULE__, fn config ->
      Map.update!(config, key, fn _ -> value end)
    end)
  end

  @spec get_env(atom, binary) :: binary
  defp get_env(key, scope \\ :vimeo) do
    Application.get_env(scope, key)
    || "#{scope}_#{key}" |> String.upcase |> System.get_env
  end
end
