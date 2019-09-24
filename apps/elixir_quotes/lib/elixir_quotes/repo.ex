defmodule Quotes.Repo do
  use Ecto.Repo,
    otp_app: :elixir_quotes,
    adapter: Ecto.Adapters.Postgres
end
