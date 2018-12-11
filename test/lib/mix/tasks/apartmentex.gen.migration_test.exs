defmodule Mix.Tasks.Apartmentex.Gen.MigrationTest do
  use ExUnit.Case, async: true

  import Support.FileHelpers
  import Mix.Tasks.Apartmentex.Gen.Migration, only: [run: 1]
  import Apartmentex.MigrationsPathBuilder

  defmodule TestRepo do
    def __adapter__ do
      true
    end

    def config do
      [otp_app: :apartmentex]
    end
  end

  @migrations_path tenant_migrations_path(TestRepo)

  setup do
    File.rm_rf!(priv_path_for(TestRepo))
    :ok
  end

  test "generates a new migration" do
    run(["-r", to_string(TestRepo), "my_migration"])
    assert [name] = File.ls!(@migrations_path)
    assert String.match?(name, ~r/^\d{14}_my_migration\.exs$/)

    assert_file(Path.join(@migrations_path, name), fn file ->
      assert file =~
               "defmodule Mix.Tasks.Apartmentex.Gen.MigrationTest.TestRepo.TenantMigrations.MyMigration do"

      assert file =~ "use Ecto.Migration"
      assert file =~ "def change do"
    end)
  end

  test "underscores the filename when generating a migration" do
    run(["-r", to_string(TestRepo), "MyMigration"])
    assert [name] = File.ls!(@migrations_path)
    assert String.match?(name, ~r/^\d{14}_my_migration\.exs$/)
  end

  test "raises when missing file" do
    assert_raise Mix.Error, fn -> run(["-r", to_string(TestRepo)]) end
  end
end
