defmodule Quotes.Tag do
  use Ecto.Schema

  import Ecto.Changeset

  schema "tags" do
    field :tag_name, :string
  end

  def changeset(%Quotes.Tag{} = tag, attrs \\ %{}) do
    tag
    |> cast(attrs, [:tag_name])
    |> update_change(:tag_name, &String.downcase/1)
    |> validate_required([:tag_name])
    |> unique_constraint(:tag_name)
  end
end
