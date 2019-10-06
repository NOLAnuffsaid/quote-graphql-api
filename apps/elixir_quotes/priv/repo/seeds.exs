# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Quotes.Repo.insert!(%Quotes.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
gen_tags = fn -> (1..3) |> Enum.random() |> Faker.Util.list(&Faker.Industry.sub_sector/0) end

gen_originator_name_params = fn ->
  web_name = &Faker.Internet.user_name/0
  full_name = &Faker.Name.name/0
  first_name = &Faker.Name.first_name/0
  poke_name = &Faker.Pokemon.name/0
  star_wars_name = &Faker.StarWars.character/0
  super_name = &Faker.Superhero.name/0

  func = Enum.random [web_name, full_name, first_name, poke_name, star_wars_name, super_name]
  func.()
end

gen_quote_text = fn ->(4..10) |> Enum.random() |> Faker.Lorem.sentence() end

gen_data = fn ->
  %{:name => gen_originator_name_params.(),
    :quotes => (2..4) |> Enum.random() |> Faker.Util.list(fn ->
      %{:quote_text => gen_quote_text.(),
        :tags => gen_tags.() |> Enum.map(fn t -> %{:tag_name => t} end)
      } end)
  }
end

alias Quotes.{Originator, Repo, Quote, Tag}

insert_o = fn %{:name => _n} = attrs -> %Originator{} |> Originator.changeset(attrs) |> Repo.insert!() end
insert_q = fn %{:quote_text => _qt, :originator_id => _o_id} = attrs -> %Quote{} |> Quote.changeset(attrs) |> Repo.insert!() end
insert_t = fn %{:tag_name => tn} = attrs ->
  case Repo.get_by(Tag, %{:tag_name => String.downcase(tn)}) do
    %Tag{} = schema -> schema
    _ -> %Tag{} |> Tag.changeset(attrs) |> Repo.insert!()
  end
end

data = (9..14) |> Enum.random() |> Faker.Util.list(gen_data)

m_to_m_list =
  for o <- data,
    %Originator{:id => o_id} = insert_o.(o),
    q <- o.quotes,
    %Quote{:id => q_id} = insert_q.(Map.merge(q, %{:originator_id => o_id})),
    t <- q.tags,
    %Tag{:id => t_id} = insert_t.(Map.merge(t, %{:quote_id => q_id}))
    do
    %{:tag_id => t_id, :quote_id => q_id}
  end

Repo.insert_all("quotes_tags", m_to_m_list)
