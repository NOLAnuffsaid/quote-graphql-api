defmodule Quotes.Repo.Migrations.AssocOriginatorsQuotes do
  use Ecto.Migration

  def change do
    alter table(:quotes) do
      add :originator_id, references(:originators), on_delete: :delete_all
    end

    create index(:quotes, [:originator_id])
  end
end
