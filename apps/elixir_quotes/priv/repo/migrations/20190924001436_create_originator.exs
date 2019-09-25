defmodule Quotes.Repo.Migrations.CreateOriginator do
  use Ecto.Migration

  def change do
    create table(:originators) do
      add :name, :string
    end

    create unique_index(:originators, [:name])
  end
end
