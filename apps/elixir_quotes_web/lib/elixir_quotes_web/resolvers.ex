defmodule QuotesWeb.Resolvers do
  require Logger

  import Ecto.Query, only: [from: 2]

  def for_originators(_, %{:search => %{:contain => n, :order => ord}}, _) when is_binary(n) do
    query = from o in Quotes.Originator, where: ilike(o.name, ^"%#{n}%"), order_by: {^ord, :name}
    {:ok, Quotes.Repo.all(query)}
  end

  def for_originators(_, _, _) do
    {:ok, Quotes.get_all_originators()}
  end

  def get_originator(_, %{:id => binary_id}, _) do
    case Integer.parse(binary_id) do
      {id, _} ->
        {:ok, Quotes.get_originator(id)}
      _ ->
        {:error, message: "invalid arg", details: :invalidarg}
    end
  end

  def add_originator(_, %{input: params}, _) do
    require IEx; IEx.pry()
    case Quotes.add_originator(params) do
      {:ok, %Quotes.Originator{}} = resp ->
        resp
      {:error, _} ->
        {:error, message: "invalid arg", details: :invalidarg}
    end
  end

  def for_quotes(_, _, _) do
    {:ok, Quotes.get_all_quotes()}
  end

  def get_quotes_by_tag(_, %{tag_id: binary_id}, _) do
    case Integer.parse(binary_id) do
      {id, _} ->
        {:ok, Quotes.get_tag(id)}
      _ ->
        {:error, message: "invalid arg", details: :invalidarg}
    end
  end

end
