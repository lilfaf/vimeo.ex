defmodule Vimeo.TestHelper do
  @moduledoc false

  @doc """
  This method sets up exvcr and the Vimeo client for testing
  """
  def setup do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes", "fixture/custom_cassettes")
    ExVCR.Config.filter_url_params(true)
    ExVCR.Config.filter_sensitive_data("client_id=.+",     "<REMOVED>")
    ExVCR.Config.filter_sensitive_data("client_secret=.+", "<REMOVED>")
    ExVCR.Config.filter_sensitive_data("bearer .+", "<REMOVED>")
    ExVCR.Config.filter_sensitive_data("basic .+", "<REMOVED>")

    Dotenv.load!
  end
end

ExUnit.start
