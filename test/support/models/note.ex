defmodule Apartmentex.Note do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notes" do
    field(:body, :string)
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:body])
  end
end
