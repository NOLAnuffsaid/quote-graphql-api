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
gen_originator_name_params = fn ->
  web_name = &Faker.Internet.user_name/0
  full_name = &Faker.Name.name/0
  first_name = &Faker.Name.first_name/0
  poke_name = &Faker.Pokemon.name/0
  star_wars_name = &Faker.StarWars.character/0
  super_name = &Faker.Superhero.name/0

  func = Enum.random [web_name, full_name, first_name, poke_name, star_wars_name, super_name]
  %{:name => func.()}
end


gen_quote_text = fn ->(4..10) |> Enum.random() |> Faker.Lorem.sentence() end
gen_quote_params = fn t -> %{:quote_text => t} end





