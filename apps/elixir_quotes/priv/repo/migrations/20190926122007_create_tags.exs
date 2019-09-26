defmodule Quotes.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :tag_name, :string
    end

    create unique_index(:tags, :tag_name)
  end
end
