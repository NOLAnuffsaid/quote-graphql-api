defmodule Quotes.Quote do
  use Ecto.Schema

  import Ecto.Changeset

  schema "quotes" do
    field :quote_text, :string
  end

  def changeset(%Quotes.Quote{} = quote, attrs \\ %{}) do
    quote
    |> cast(attrs, [:quote_text])
    |> update_change(:quote_text, &String.downcase/1)
    |> validate_required([:quote_text])
  end
end
