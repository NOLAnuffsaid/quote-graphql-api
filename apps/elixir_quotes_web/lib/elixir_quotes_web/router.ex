defmodule QuotesWeb.Router do
  use QuotesWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", QuotesWeb do
    pipe_through :api
  end
end
