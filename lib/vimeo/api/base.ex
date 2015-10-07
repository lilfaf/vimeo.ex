defmodule Vimeo.API.Base do
  @moduledoc """
  Provides general request making and handling functionality (for internal use).
  """
  use HTTPoison.Base

  ## ------- Overrides

  def process_url(url) do
    "https://api.vimeo.com/#{url}"
  end

  # @doc """
  # General HTTP `GET` request function. Takes a url part, a token
  # and optionally a list of params.
  # """
  def get(url, token, params \\ []) do
    request!(:get, url, "", build_headers(token), [params: params])
    |> handle_response
  end

  # @doc """
  # General HTTP `POST` request function. Takes a url part, a token
  # and optionally data Map and list of params.
  # """
  def post(url, token, data \\ "", params \\ []) do
    request!(:post , url, data, build_headers(token), [params: params])
    |> handle_response
  end

  # @doc """
  # General HTTP `PATCH` request function. Takes a url part, a token
  # and optionally data Map and list of params.
  # """
  def patch(url, token, data \\ "", params \\ []) do
    request!(:patch , url, data, build_headers(token), [params: params]) 
    |> handle_response
  end

  # @doc """
  # General HTTP `DELETE` request function. Takes a url part, a token
  # and optionally a list of params.
  # """
  def delete(url, token, params \\ []) do
    request!(:delete, url, "", build_headers(token), [params: params])
    |> handle_response
  end

  ## ------- Private

  defp build_headers(:global), do: build_headers(Vimeo.Config.get.access_token)

  defp build_headers(token) do
    ["Authorization": "Bearer #{token}", "Content-type": "application/json"]
  end

  # Returns the response on successfull request or raise an exception as Vimeo.Error
  defp handle_response(response) do
    case response do
      %HTTPoison.Response{status_code: 200, body: body} -> 
        Poison.decode!(body, keys: :atoms)
      %HTTPoison.Response{status_code: 204} -> :ok
      %HTTPoison.Response{body: body} ->
        body = Poison.decode!(body, keys: :atoms)
        raise Vimeo.Error, [code: response.status_code, message: body.error]
    end
  end
end
