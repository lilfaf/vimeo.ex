# Vimeo.ex

[![Build Status](https://travis-ci.org/seshook/vimeo.ex.svg)](https://travis-ci.org/seshook/vimeo.ex)
[![Coverage Status](https://coveralls.io/repos/seshook/vimeo.ex/badge.svg?branch=master&service=github)](https://coveralls.io/github/seshook/vimeo.ex?branch=master)

#### [Read the docs](https://hexdocs.pm/vimeo.ex)

## Usage

### Installation

Add the following to your `mix.exs`

````elixir

def application do
  [mod: {VimeoExample, []}, applications: [:vimeo]]
end

defp deps do
  [{:vimeo, "~> 0.1.0-dev"}]
end

````

### Configuration

Vimeo client will first look for application variables, then environment variables. This is useful if you want to set application variables locally and environment variables in production. That being said, I recommend using [Dotenv](https://github.com/avdi/dotenv_elixir) locally.

`config/dev.exs`
````elixir
config :vimeo,
  vimeo_client_id: "YOUR_CLIENT_ID",
  vimeo_client_secret: "YOUR_CLIENT_SECRET",
  vimeo_redirect_uri: "YOUR_ACCESS_TOKEN"
````

`.env`
````bash
VIMEO_CLIENT_ID=YOUR_CLIENT_ID
VIMEO_CLIENT_SECRET=YOUR_CLIENT_SECRET
VIMEO_ACCESS_TOKEN=YOUR_ACCESS_TOKEN
````

You can also configure these programatically at runtime if you wish:
````elixir
iex> Vimeo.configure("YOUR_CLIENT_ID", "YOUR_CLIENT_SECRET", "YOUR_ACCESS_TOKEN")
iex> Vimeo.token("YOUR_ACCESS_TOKEN")
````

### Usage

````elixir
iex> Vimeo.Me.info
%Elixtagram.Model.User{...}
````

All of the available methods and the ways to call them are [in the docs](https://hexdocs.pm/vimeo.ex/Vimeo.html)

## TODO

Work in progress, many things are missing:

* Add endpoints on Videos and Users modules
* Handle Picture and video upload
* Handle pagination metadata
* Handle nested data mapping
* Improve documentation about Vimeo API query params and expected token scope

## License

Vimeo.ex is licensed under the MIT License. See the LICENSE file for details.
