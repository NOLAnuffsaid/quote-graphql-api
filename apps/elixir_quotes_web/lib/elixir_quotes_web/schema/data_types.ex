defmodule QuotesWeb.Schema.DataTypes do
  use Absinthe.Schema.Notation

  object :originator do
    field :id, :id
    field :name, :string
    field :quotes, list_of(:quote)
  end

  object :quote do
    field :id, :id
    field :quote_text, :string
    field :tags, list_of(:tag)
    field :originator, :originator
  end

  object :tag do
    field :id, :id
    field :tag_name, :string
    field :quotes, list_of(:quote)
  end
end
