defmodule Apartmentex do
  alias Ecto.Changeset
  import Apartmentex.PrefixBuilder

  defdelegate drop_tenant(repo, tenant), to: Apartmentex.TenantActions

  defdelegate migrate_tenant(repo, tenant, direction \\ :up, opts \\ []),
    to: Apartmentex.TenantActions

  defdelegate new_tenant(repo, tenant), to: Apartmentex.TenantActions

  def all(repo, queryable, tenant, opts \\ []) when is_list(opts) do
    queryable
    |> add_prefix_to_query(tenant)
    |> repo.all(opts)
  end

  @doc """
  See `Ecto.Repo.get/3`
  """
  def get(repo, queryable, id, tenant, opts \\ []) do
    queryable
    |> add_prefix_to_query(tenant)
    |> repo.get(id, opts)
  end

  @doc """
  See `Ecto.Repo.get!/3`
  """
  def get!(repo, queryable, id, tenant, opts \\ []) do
    queryable
    |> add_prefix_to_query(tenant)
    |> repo.get!(id, opts)
  end

  @doc """
  See `Ecto.Repo.get_by/3`
  """
  def get_by(repo, queryable, clauses, tenant, opts \\ []) do
    queryable
    |> add_prefix_to_query(tenant)
    |> repo.get_by(clauses, opts)
  end

  @doc """
  See `Ecto.Repo.get_by!/3`
  """
  def get_by!(repo, queryable, clauses, tenant, opts \\ []) do
    queryable
    |> add_prefix_to_query(tenant)
    |> repo.get_by!(clauses, opts)
  end

  @doc """
  See `Ecto.Repo.one/2`
  """
  def one(repo, queryable, tenant, opts \\ []) do
    queryable
    |> add_prefix_to_query(tenant)
    |> repo.one(opts)
  end

  @doc """
  See `Ecto.Repo.one!/2`
  """
  def one!(repo, queryable, tenant, opts \\ []) do
    queryable
    |> add_prefix_to_query(tenant)
    |> repo.one!(opts)
  end

  # model derived functions

  @doc """
  See `Ecto.Repo.insert/2`
  """
  def insert(repo, model_or_changeset, tenant, opts \\ []) do
    model_or_changeset
    |> add_prefix(tenant)
    |> repo.insert(opts)
  end

  @doc """
  See `Ecto.Repo.insert!/2`
  """
  def insert!(repo, model_or_changeset, tenant, opts \\ []) do
    model_or_changeset
    |> add_prefix(tenant)
    |> repo.insert!(opts)
  end

  @doc """
  See `Ecto.Repo.update/2`
  """
  def update(repo, model_or_changeset, tenant, opts \\ []) do
    model_or_changeset
    |> add_prefix(tenant)
    |> repo.update(opts)
  end

  @doc """
  See `Ecto.Repo.update!/2`
  """
  def update!(repo, model_or_changeset, tenant, opts \\ []) do
    model_or_changeset
    |> add_prefix(tenant)
    |> repo.update!(opts)
  end

  @doc """
  See `Ecto.Repo.update_all/3`
  """
  def update_all(repo, queryable, updates, tenant, opts \\ []) do
    queryable
    |> add_prefix_to_query(tenant)
    |> repo.update_all(updates, opts)
  end

  @doc """
  See `Ecto.Repo.insert_or_update/2`
  """
  def insert_or_update(repo, model_or_changeset, tenant, opts \\ []) do
    model_or_changeset
    |> add_prefix(tenant)
    |> repo.insert_or_update(opts)
  end

  @doc """
  See `Ecto.Repo.insert_or_update!/2`
  """
  def insert_or_update!(repo, model_or_changeset, tenant, opts \\ []) do
    model_or_changeset
    |> add_prefix(tenant)
    |> repo.insert_or_update!(opts)
  end

  @doc """
  See `Ecto.Repo.delete/2`
  """
  def delete(repo, model_or_changeset, tenant, opts \\ []) do
    model_or_changeset
    |> add_prefix(tenant)
    |> repo.delete(opts)
  end

  @doc """
  See `Ecto.Repo.delete!/2`
  """
  def delete!(repo, model_or_changeset, tenant, opts \\ []) do
    model_or_changeset
    |> add_prefix(tenant)
    |> repo.delete!(opts)
  end

  @doc """
  See `Ecto.Repo.delete_all/2`
  """
  def delete_all(repo, queryable, tenant, opts \\ []) do
    queryable
    |> add_prefix_to_query(tenant)
    |> repo.delete_all(opts)
  end

  @doc """
  See `Ecto.Repo.exists?/2`
  """
  def exists?(repo, queryable, tenant, opts \\ []) do
    queryable
    |> add_prefix_to_query(tenant)
    |> repo.exists?(opts)
  end

  # helpers

  defp add_prefix(%Changeset{} = changeset, tenant) do
    %{changeset | data: add_prefix(changeset.data, tenant)}
  end

  defp add_prefix(%{__struct__: _} = model, tenant) do
    Ecto.put_meta(model, prefix: build_prefix(tenant))
  end

  defp add_prefix_to_query(queryable, tenant) do
    queryable
    |> Ecto.Queryable.to_query()
    |> Map.put(:prefix, build_prefix(tenant))
  end
end
