defmodule QuotesWeb.RestController do
  use QuotesWeb, :controller

  def originators(conn, _), do: json(conn, :ok)
  def add_originators(conn, _), do: json(conn, :ok)
  def originator(conn, _), do: json(conn, :ok)
  def remove_originator(conn, _), do: json(conn, :ok)
  def quotes_for(conn, _), do: json(conn, :ok)
  def add_quote_for(conn, _), do: json(conn, :ok)
  def quote_for(conn, _), do: json(conn, :ok)
  def update_quote(conn, _), do: json(conn, :ok)
  def remove_quote(conn, _), do: json(conn, :ok)
  def tags_for_quote(conn, _), do: json(conn, :ok)
  def add_tag_to_quote(conn, _), do: json(conn, :ok)
  def remove_tag_from_quote(conn, _), do: json(conn, :ok)
end
