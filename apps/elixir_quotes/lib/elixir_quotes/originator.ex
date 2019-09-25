defmodule Quotes.Originator do
  use Ecto.Schema

  import Ecto.Changeset

  schema "originators" do
    field :name, :string
  end

  def changeset(%Quotes.Originator{} = originator, attrs \\ %{}) do
    originator
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
