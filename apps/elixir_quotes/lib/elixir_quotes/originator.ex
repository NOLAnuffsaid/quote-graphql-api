defmodule Quotes.Originator do
  use Ecto.Schema

  import Ecto.Changeset

  schema "originators" do
    field :name, :string
    has_many :quotes, Quotes.Quote
  end

  def changeset(%Quotes.Originator{} = originator, attrs \\ %{}) do
    originator
    |> cast(attrs, [:name])
    |> cast_assoc(:quotes, with: &Quotes.Quote.changeset/2)
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

  def changeset_assoc(%Quotes.Originator{} = originator, attrs \\ %{}) do
    originator
    |> changeset(attrs)
    |> cast_assoc(:quotes, with: &Quotes.Quote.changeset/2)
  end
end
