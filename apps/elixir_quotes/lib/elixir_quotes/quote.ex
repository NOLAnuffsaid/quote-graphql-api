defmodule Quotes.Quote do
  use Ecto.Schema

  import Ecto.Changeset

  schema "quotes" do
    field :quote_text, :string
    belongs_to :originator, Quotes.Originator
    many_to_many :tags, Quotes.Tag, join_through: "quotes_tags"
  end

  def changeset(%Quotes.Quote{} = quote, attrs \\ %{}) do
    quote
    |> cast(attrs, [:quote_text, :originator_id])
    |> update_change(:quote_text, &String.downcase/1)
    |> validate_required([:quote_text, :originator_id])
    |> assoc_constraint(:originator)
  end
end
