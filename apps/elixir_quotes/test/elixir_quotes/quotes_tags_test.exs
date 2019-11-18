defmodule Quotes.QuotesTagsTest do
  use ExUnit.Case
  use ExUnitProperties

  describe "add_quotes/2" do

    setup do
      :ok = Ecto.Adapters.SQL.Sandbox.checkout(Quotes.Repo)

      %Quotes.Originator{id: id} = %{:name => Quotes.Test.SeedData.gen_originator()}
      [originator_id: id]
    end

    property "creates a quote, assocs with an originator and its tags", [originator_id: o_id] do
    end
  end
end
