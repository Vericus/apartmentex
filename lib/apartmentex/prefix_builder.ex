defmodule Apartmentex.PrefixBuilder do
  @typedoc "Tenant identifier"
  @type tenant :: integer() | String.t() | %{id: integer() | String.t()}

  @doc false
  def schema_prefix() do
    Application.get_env(:apartmentex, :schema_prefix) || "tenant_"
  end

  @doc """
  Build a Ecto schema prefix from a tenant identifier.
  """
  @spec build_prefix(tenant()) :: String.t()
  def build_prefix(tenant) when is_integer(tenant),
    do: schema_prefix() <> Integer.to_string(tenant)

  def build_prefix(tenant) when is_binary(tenant), do: schema_prefix() <> tenant

  def build_prefix(tenant) do
    cond do
      is_binary(tenant.id) -> build_prefix(tenant.id)
      is_integer(tenant.id) -> build_prefix(tenant.id)
    end
  end
end
