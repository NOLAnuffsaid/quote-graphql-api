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
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
