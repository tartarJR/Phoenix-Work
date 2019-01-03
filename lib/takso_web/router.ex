defmodule TaksoWeb.Router do
  use TaksoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TaksoWeb do
    pipe_through :browser

    get "/", PageController, :index

    # resources "/users", UserController

    get "/users", UserController, :index
    get "/users/new", UserController, :new
    post "/users", UserController, :create
    get "/users/:id/show", UserController, :show
    get "/users/:id/edit", UserController, :edit
    put "/users/:id", UserController, :update
    delete "/users/:id", UserController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", TaksoWeb do
  #   pipe_through :api
  # end

  # Other scopes may use custom stacks.
  scope "/api", TaksoWeb do
    pipe_through :api

    get "/items", ItemAPIController, :summary
    post "/items", ItemAPIController, :create
    post "/bids", ItemAPIController, :bids
  end

end
