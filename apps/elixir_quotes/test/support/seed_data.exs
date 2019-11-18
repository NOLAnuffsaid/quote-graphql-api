defmodule Quotes.Test.SeedData do
  use ExMachina.Ecto, repo: Quotes.Repo

  defp gen_tags(),
    do: (1..3) |> Enum.random() |> Faker.Util.list(&Faker.Industry.sub_sector/0)

  defp gen_originator() do
    web_name = &Faker.Internet.user_name/0
    full_name = &Faker.Name.name/0
    first_name = &Faker.Name.first_name/0
    poke_name = &Faker.Pokemon.name/0
    star_wars_name = &Faker.StarWars.character/0
    super_name = &Faker.Superhero.name/0

    func = Enum.random [web_name, full_name, first_name, poke_name, star_wars_name, super_name]
    func.()
  end

  defp gen_quote(),
    do: (4..10) |> Enum.random() |> Faker.Lorem.sentence()

  defp gen_data(),
    do: %{
      :name => gen_originator_name_params.(),
      :quotes => (2..4) |> Enum.random() |> Faker.Util.list(fn ->
        %{:quote_text => gen_quote_text.(),
          :tags => gen_tags.() |> Enum.map(fn t -> %{:tag_name => t} end)
        } end)
    }

  def seed_data() do
    (3..6)
    |> Enum.random()
    |> Faker.Util.list(gen_data)
    |> Enum.each(&Quotes.add_originator/1)
  end
end
