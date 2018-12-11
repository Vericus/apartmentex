defmodule Apartmentex.TestPostgresRepo do
  use Ecto.Repo, otp_app: :apartmentex, adapter: Ecto.Adapters.Postgres
end

Code.compiler_options(ignore_module_conflict: true)

Mix.Task.run("ecto.drop", ["quiet", "-r", "Apartmentex.TestPostgresRepo"])
Mix.Task.run("ecto.create", ["quiet", "-r", "Apartmentex.TestPostgresRepo"])

{:ok, _pid} = Apartmentex.TestPostgresRepo.start_link()

ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Apartmentex.TestPostgresRepo, :auto)
