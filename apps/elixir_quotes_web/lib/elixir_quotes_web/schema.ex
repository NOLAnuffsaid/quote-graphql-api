defmodule QuotesWeb.Schema do
  use Absinthe.Schema

  alias QuotesWeb.Resolvers

  import_types QuotesWeb.Schema.DataTypes

  @desc "Sorts results"
  enum :sort_order do
    value :asc
    value :desc
  end

  @desc "Finds originators based on given string"
  input_object :originator_search do

    @desc "String to match on"
    field :contain, :string

    @desc "Order to return results in"
    field :order, :sort_order
  end

  query do
    @desc "returns all originators"
    field :originators, list_of(:originator) do
      resolve &Resolvers.for_originators/3
    end

    @desc "returns all quotes"
    field :quotes, list_of(:quote) do
      resolve &Resolvers.for_quotes/3
    end

    @desc "returns originators matching the query string"
    field :originator_search, list_of(:originator) do
      arg :search, :originator_search
      resolve &Resolvers.for_originators/3
    end

    field :originator, :originator do
      arg :id, :id
      resolve &Resolvers.get_originator/3
    end

    @desc "quotes that are listed for a given tag"
    field :quotes_for_tag, :tag do
      arg :tag_id, :id
      resolve &Resolvers.get_quotes_by_tag/3
    end
  end

  @desc ""
  input_object :originator_params do
    field :name, non_null(:string)
    field :quotes, list_of(:quote)
  end

  mutation do
    field :create_originator, :originator do
      arg :input, non_null(:originator_params)
      resolve &Resolvers.add_originator/3
    end
  end
end
