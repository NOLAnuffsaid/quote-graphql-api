defmodule QuotesWeb.GraphqlController do
  use QuotesWeb, :controller

  def quotes(conn, _), do: json(conn, :ok)
end
