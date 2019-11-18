defmodule Quotes.OriginatorTest do
  use ExUnit.Case
  use ExUnitProperties

  describe "add_originator/1" do

    setup do
      :ok = Ecto.Adapters.SQL.Sandbox.checkout(Quotes.Repo)
    end

    property "creates an originator with no assoc data" do
      check all name <- StreamData.string(:alphanumeric),
                name != "" do
        attrs = %{name: name, quotes: []}

        case Quotes.add_originator(attrs) do
          {:ok, %Quotes.Originator{}} -> assert true
          _ -> assert false
        end
      end

    end

    property "creates an originator with assoc data" do
      check all attrs <- gen_originator_with_assoc_data() do
        case Quotes.add_originator(attrs) do
          {:ok, %Quotes.Originator{}} -> assert true
          out -> IO.inspect(out); assert false
        end
      end
    end
  end

  defp gen_originator_with_assoc_data() do
    gen all name <- StreamData.string(:alphanumeric),
            name != "",
            quotes <- StreamData.list_of(gen_quotes_with_tags(), max_length: 8) do
      %{:name => name, :quotes => quotes}
    end
  end

  defp gen_quotes_with_tags() do
    gen all quote_text <- StreamData.string(:alphanumeric),
            quote_text != "",
            tags <- StreamData.list_of(
              StreamData.fixed_map(%{tag_name: StreamData.string(:alphanumeric, min_length: 1)}),
              max_length: 3
            ) do
      %{:quote_text => quote_text, :tags => tags}
    end
  end
end
