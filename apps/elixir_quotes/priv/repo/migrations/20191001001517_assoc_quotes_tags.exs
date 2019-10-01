defmodule Quotes.Repo.Migrations.AssocQuotesTags do
  use Ecto.Migration

  def change do
    create table(:quotes_tags, primary_key: false) do
      add :quote_id, references(:quotes)
      add :tag_id, references(:tags)
    end
  end
end
