defmodule GenSchemaEn.Repo do
  use Ecto.Repo,
    otp_app: :gen_schema_en,
    adapter: Ecto.Adapters.Postgres
end
