defmodule Vimeo.API do
  @moduledoc """
  Provides request making and handling functionalities (internal use).
  """

  use HTTPoison.Base

  @endpoint "https://api.vimeo.com/"

  @headers ["Content-Type": "application/json"]

  # HTTP methods --------------------------------------------------------------

  @doc """
  Issues GET request. Takes a url and an optional params list.
  """
  @spec get(binary, list) :: map
  def get(url, params \\ []), do: json_request(:get, url, "", params)

  @doc """
  Issues POST request. Takes a url and an optional data Map.
  """
  @spec post(binary, binary) :: map
  def post(url, body \\ ""), do: json_request(:post, url, body)

  @doc """
  Issues PUT request. Takes a url and an optional data Map.
  """
  @spec post(binary, binary) :: map
  def put(url, body \\ ""), do: json_request(:put, url, body)

  @doc """
  Issues PATCH request. Takes a url and an optional data Map.
  """
  @spec post(binary, binary) :: map
  def patch(url, body \\ ""), do: json_request(:patch, url, body)

  @doc """
  Issues DELETE request. Takes a url.
  """
  @spec post(binary) :: map
  def delete(url), do: json_request(:delete, url)

  @doc """
  Send HTTP json request formatted for the Vimeo API.
  """
  @spec json_request(atom, binary, binary, list) :: map
  def json_request(method, url, body \\ "", params \\ []) do
    request!(method, url, body, [], [params: params]) |> handle_response
  end

  # Private -------------------------------------------------------------------

  defp process_url(url), do: @endpoint <> url

  defp process_request_headers(headers) do
    @headers ++ authorization_header ++ headers
  end

  defp process_request_body(""), do: ""
  defp process_request_body(body) do
    Enum.into(body, %{}) |> Poison.encode!
  end

  def process_response_body(""), do: ""
  def process_response_body(body) do
    Poison.decode!(body, keys: :atoms)
  end

  defp authorization_header do
    case Vimeo.config do
      %{access_token: nil, client_id: id, client_secret: secret} ->
        [{ "Authorization", "basic #{Base.encode64("#{id}:#{secret}")}" }]
      %{access_token: token} ->
        [{ "Authorization", "bearer #{token}" }]
      _ -> []

    end
  end

  defp handle_response(response) do
    case response.status_code do
      code when code in 200..299 -> response.body
      code -> raise Vimeo.Error, [code: code, message: response.body.error]
    end
  end
end