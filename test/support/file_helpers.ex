defmodule Support.FileHelpers do
  import ExUnit.Assertions

  @doc """
  Asserts a file was generated.
  """
  def assert_file(file) do
    assert File.regular?(file), "Expected #{file} to exist, but does not"
  end

  @doc """
  Asserts a file was generated and that it matches a given pattern.
  """
  def assert_file(file, callback) when is_function(callback, 1) do
    assert_file(file)
    callback.(File.read!(file))
  end

  def assert_file(file, match) do
    assert_file(file, &assert(&1 =~ match))
  end
end
