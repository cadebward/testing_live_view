defmodule BobWeb.Router do
  use BobWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BobWeb do
    pipe_through :browser

    live "/", FormLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", BobWeb do
  #   pipe_through :api
  # end
end
