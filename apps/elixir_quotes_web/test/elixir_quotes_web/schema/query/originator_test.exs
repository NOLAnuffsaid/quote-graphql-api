defmodule QuotesWeb.SchemaTest do
  use QuotesWeb.ConnCase, async: true

  setup do
    #seed_data()
  end

  @query """
  {
    originators {
      id
      name
    }
  }
  """

  describe "originator queries" do
    test "should not contain duplicate names" do
      conn = build_conn()
      resp = get(conn, "/api", query: @query) |> json_response(200)
      names = resp["data"]["originators"]|> Enum.map(fn o -> o["name"] end)

      assert names == Enum.uniq(names)
    end
  end
end
