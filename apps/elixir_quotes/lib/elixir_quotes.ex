defmodule Quotes do
  @moduledoc """
  Quotes keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Quotes.{Originator, Quote, Tag, Repo}

  import Ecto.Query

  def add_originator(%{:name => n, :quotes => qs} = payload) do
    case Repo.get_by(Originator, %{:name => n}) do
      %Originator{:id => o_id} ->
        add_quotes(o_id, qs)
      _ ->
        %Originator{:id => o_id} = %Originator{} |> Originator.changeset(payload) |> Repo.insert!()
        add_quotes(o_id, qs)
    end
  end

  def add_originator(%{:name => _n} = attrs) do
    case Repo.get_by(Originator, attrs) do
      %Originator{} = o -> o
      _ -> %Originator{} |> Originator.changeset(attrs) |> Repo.insert!()
    end

    :ok
  end

  def add_originator(_), do: :error

  def delete_originator(o_id) when is_number(o_id), do: Originator |> Repo.get(o_id) |> Repo.delete()
  def delete_originator(_), do: :error

  def add_quotes(_, []), do: :ok
  def add_quotes(originator_id, qs) do
    qs
    |> Enum.each(fn q ->
      %Quote{:id => q_id} = q |> Map.merge(%{:originator_id => originator_id}) |> add_quote()
      ts = add_tags(q.tags)

      assoc_quotes_tags(q_id, %{:tags => ts})
    end)
  end

  def add_quote(%{:originator_id => _o_id, :quote_text => _qt} = attrs), do: %Quote{} |> Quote.changeset(attrs) |> Repo.insert!()
  def add_quote(_), do: :error

  # Must delete the many to many tag assoc as well.
  def delete_quote(quote_id) when is_number(quote_id), do: Quote |> Repo.get(quote_id) |> Repo.delete()
  def delete_quote(_), do: :error

  def update_quote(quote_id, %{:tags => _ts} = attrs) when is_number(quote_id) do
    query = from q in Quote, where: q.id == ^quote_id, preload: [:originator, :tags]

    %Quote{:id => q_id} = query
      |> Repo.one()
      |> Quote.changeset(attrs)
      |> Repo.update()

    assoc_quotes_tags(q_id, attrs)
  end

  def update_quote(_, _), do: :error

  def add_tags([]), do: :error
  def add_tags(ts), do: Enum.map(ts, &add_tag/1)

  def add_tag(%{:tag_name => t} = attrs) do
    updated_attrs = Map.update(attrs, :tag_name, t, &String.downcase/1)

    case Repo.get_by(Tag, updated_attrs) do
      %Tag{} = t -> t
      _ -> %Tag{} |> Tag.changeset(attrs) |> Repo.insert!()
    end
  end

  def add_tag(_), do: :error

  # Must delete the many to many quote assoc as well.
  def delete_tag(tag_id) when is_number(tag_id), do: Tag |> Repo.get(tag_id) |> Repo.delete()
  def delete_tag(_), do: :error

  defp assoc_quotes_tags(_, %{:tags => []}), do: :ok
  defp assoc_quotes_tags(quote_id, %{:tags => ts}) when is_number(quote_id) do
    quotes_tags_attrs = Enum.map(ts, fn %Tag{:id => t_id} ->
      %{:quote_id => quote_id, :tag_id => t_id}
    end)

    insert_ops_count = Enum.count(quotes_tags_attrs)
    {^insert_ops_count, _} = Repo.insert_all("quotes_tags", quotes_tags_attrs)

    :ok
  end

  defp assoc_quotes_tags(_, _), do: :error
end
