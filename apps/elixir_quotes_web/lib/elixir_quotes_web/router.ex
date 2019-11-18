defmodule QuotesWeb.Router do
  use QuotesWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug,
      schema: QuotesWeb.Schema

    unless Mix.env == :prod do
      forward "/graphiql", Absinthe.Plug.GraphiQL,
        schema: QuotesWeb.Schema,
        interface: :simple
    end
  end

#  scope "/api", QuotesWeb do
#    pipe_through :api
#
#    scope path: "/rest" do
#      get "/authors", RestController, :originators
#      post "/authors", RestController, :add_originators
#
#      get "/authors/:id", RestController, :originator
#      delete "/authors/:id", RestController, :remove_originator
#
#      get "/authors/:id/quotes", RestController, :quotes_for
#      post "/authors/:id/quotes", RestController, :add_quote_for
#
#      get "/authors/:id/quotes/:id", RestController, :quote_for
#      put "/authors/:id/quotes/:id", RestController, :update_quote
#      delete "/authors/:id/quotes/:id", RestController, :remove_quote
#
#      get "/authors/:id/quotes/:id/tags", RestController, :tags_for_quote
#      post "/authors/:id/quotes/:id/tags", RestController, :add_tag_to_quote
#
#      post "/authors/:id/quotes/:id/tags/:id", RestController, :add_tag_to_quote
#      delete "/authors/:id/quotes/:id/tags/:id", RestController, :remove_tag_from_quote
#    end
#
#    scope path: "/graphql" do
#      get "/quotes", GraphqlController, :quotes
#    end
#  end
end
