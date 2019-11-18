defmodule QuotesWeb.Factory do
  use ExMachina.Ecto, repo: Quotes.Repo

  def tag_factory(),
    do: %{:tag_name => Faker.Industry.sub_sector()}

  def originator_factory() do
    web_name = &Faker.Internet.user_name/0
    full_name = &Faker.Name.name/0
    first_name = &Faker.Name.first_name/0
    poke_name = &Faker.Pokemon.name/0
    star_wars_name = &Faker.StarWars.character/0
    super_name = &Faker.Superhero.name/0

    func = Enum.random [web_name, full_name, first_name, poke_name, star_wars_name, super_name]
    %{:name => func.(), :quotes => [build(:quote)]}
  end

  def quote_factory(),
    do: %{:quote_text => Faker.Lorem.sentence(), :tags => build_list(:tag)}

end
