defmodule Quotes.Repo.Migrations.CreateQuote do
  use Ecto.Migration

  def change do
    create table(:quotes) do
      add :quote_text, :string
    end
  end
end
