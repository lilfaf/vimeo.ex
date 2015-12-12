defmodule Vimeo.API do
  @moduledoc """
  Provides request making and handling functionalities (internal use).
  """

  use HTTPoison.Base

  @endpoint "https://api.vimeo.com/"

  @headers [
    "Content-Type": "application/json",
    "Accept": "application/vnd.vimeo.*+json;version=3.2"
  ]

  # HTTP methods --------------------------------------------------------------

  @doc """
  Issues GET request.
  Takes a url and an optional params map.
  """
  @spec get(binary, map) :: map
  def get(url, params \\ %{}), do: do_request(:get, url, "", params)

  @doc """
  Issues POST request.
  Takes a url and an optional data Map.
  """
  @spec post(binary, map) :: map
  def post(url, body \\ ""), do: do_request(:post, url, body)

  @doc """
  Issues PUT request.
  Takes a url and an optional data Map.
  """
  @spec post(binary, map) :: map
  def put(url, body \\ ""), do: do_request(:put, url, body)

  @doc """
  Issues PATCH request.
  Takes a url and an optional data Map.
  """
  @spec post(binary, map) :: map
  def patch(url, body \\ ""), do: do_request(:patch, url, body)

  @doc """
  Issues DELETE request. Takes a url.
  """
  @spec post(binary) :: map
  def delete(url), do: do_request(:delete, url)

  # Private -------------------------------------------------------------------

  defp process_url(url), do: @endpoint <> url

  defp process_request_headers(headers) do
    @headers ++ authorization_header ++ headers
  end

  defp process_request_body(""), do: ""
  defp process_request_body(body) do
    body
    |> Enum.into(%{})
    |> Poison.encode!
  end

  defp process_response_body(""), do: ""
  defp process_response_body(body) do
    Poison.decode!(body, keys: :atoms)
  end

  defp authorization_header(token \\ Vimeo.access_token) do
    [{ "Authorization", "bearer #{token}" }]
  end

  defp do_request(method, url, body \\ "", params \\ %{}) do
    method
    |> request!(url, body, [], [params: params])
    |> handle_response
  end

  defp handle_response(response) do
    case response do
      %{status_code: code, body: body} when code in 200..299 -> {:ok, body}
      %{status_code: code, body: %{error: message}}  ->
        {:error, %Vimeo.Error{code: code, message: message}}
      _ -> {:error, %Vimeo.Error{}}
    end
  end
end
