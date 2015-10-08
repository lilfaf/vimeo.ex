# Vimeo.ex

[![Build Status](https://travis-ci.org/seshook/vimeo.ex.svg)](https://travis-ci.org/seshook/vimeo.ex)
[![Coverage Status](https://coveralls.io/repos/seshook/vimeo.ex/badge.svg?branch=master&service=github)](https://coveralls.io/github/seshook/vimeo.ex?branch=master)

### [Read the docs](https://hexdocs.pm/vimeo.ex)

## Usage

### Installation

Add the following to your `mix.exs`

````elixir
...

def application do
  [mod: {VimeoExample, []},
   applications: [:vimeo]]
end

...

defp deps do
  [{:vimeo, "~> 0.1.0"}]
end

...

````

### Configuration

Vimeo client will first look for application variables, then environment variables. This is useful if you want to set application variables locally and environment variables in production (e.g. on Heroku). That being said, I recommend using [Dotenv](https://github.com/avdi/dotenv_elixir) locally.

`config/dev.exs`
````elixir
config :vimeo,
  vimeo_client_id: "YOUR-CLIENT-ID",
  vimeo_client_secret: "YOUR-CLIENT-SECRET",
  vimeo_redirect_uri: "YOUR-REDIRECT-URI"
````

`.env`
````bash
VIMEO_CLIENT_ID=YOUR-CLIENT-ID
VIMEO_CLIENT_SECRET=YOUR-CLIENT-SECRET
VIMEO_REDIRECT_URI=YOUR-REDIRECT-URI
````

You can also configure these programatically at runtime if you wish:
````elixir
iex(1)> Vimeo.configure("YOUR-CLIENT-ID", "YOUR-CLIENT-SECRET", "YOUR-REDIRECT-URI")
{:ok, []}
````

### Usage

#### Authenticate a user

````elixir
# Generate a URL to send them to
iex(1)> Vimeo.authorize_url!
"https://api.vimeo.com/oauth/authorize/?client_id=XXX&redirect_uri=localhost%3A4000&response_type=code"

# Vimeo will redirect them back to your VIMEO_REDIRECT_URI, so once they're there, you need to catch the url param 'code', and exchange it for an access token.

iex(2)> code = "XXXXXXXXXX"
"XXXXXXXXXX"
iex(3)> access_token = Vimeo.get_token!(code: code).access_token
"XXXXXXXXXXXXXXXXXXXX"

# Now we can optionally set this as the global token, and make requests with it by passing :global instead of a token.
iex(4)> Vimeo.configure(:global, access_token)
{:ok, []}
````

#### Request an endpoint

````elixir
iex(1)> Vimeo.my_info("XXXXXXXXXXXXXXXXX")
%Elixtagram.Model.User{...}

iex(2)> Vimeo.my_info()
%Elixtagram.Model.User{...}
````

All of the available methods and the ways to call them are [in the docs](https://hexdocs.pm/vimeo.ex/Vimeo.html)

## TODO

Work in progress, many things are missing:

* Channels endpoint
* Groups endpoint
* Languages endpoint
* Me endpoint
* Tags endpoint
* Users endpoint
* Videos endpoint
* Pagination of results for certain data types
* Real time subscriptions

## Thanks

- [@Zensavona](https://github.com/Zensavona) for [Elixtagram](https://github.com/Zensavona/elixtagram)

## License

Vimeo.ex is licensed under the MIT License. See the LICENSE file for details.
