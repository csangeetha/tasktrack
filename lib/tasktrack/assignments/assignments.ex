defmodule Tasktrack.Assignments do
  @moduledoc """
  The Assignments context.
  """

  import Ecto.Query, warn: false
  alias Tasktrack.Repo

  alias Tasktrack.Assignments.Task

  @doc """
  Returns the list of tasks.

  ## Examples

  iex> list_tasks()
  [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
    |>Repo.preload([{:assigned_by,:manager}])
    |>Repo.preload([{:assigned_to,:manager}])
    |>Repo.preload(:time_blocks)
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

  iex> get_task!(123)
  %Task{}

  iex> get_task!(456)
  ** (Ecto.NoResultsError)

  """
  def get_task!(id) do
    Repo.get!(Task, id)
    |>Repo.preload([{:assigned_by,:manager}])
    |>Repo.preload([{:assigned_to,:manager}])
    |>Repo.preload(:time_blocks)
  end

  @doc """
  Creates a task.

  ## Examples

  iex> create_task(%{field: value})
  {:ok, %Task{}}

  iex> create_task(%{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

  iex> update_task(task, %{field: new_value})
  {:ok, %Task{}}

  iex> update_task(task, %{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task.

  ## Examples

  iex> delete_task(task)
  {:ok, %Task{}}

  iex> delete_task(task)
  {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

  iex> change_task(task)
  %Ecto.Changeset{source: %Task{}}

  """
  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end

  alias Tasktrack.Assignments.Manage

  @doc """
  Returns the list of manages.

  ## Examples

  iex> list_manages()
  [%Manage{}, ...]

  """
  def list_manages do
    Repo.all(Manage)
    |>Repo.preload(:manager)
    |>Repo.preload(:managee)
  end

  @doc """
  Gets a single manage.

  Raises `Ecto.NoResultsError` if the Manage does not exist.

  ## Examples

  iex> get_manage!(123)
  %Manage{}

  iex> get_manage!(456)
  ** (Ecto.NoResultsError)

  """
  def get_manage!(id) do
    Repo.get!(Manage, id)
    |>Repo.preload(:manager)
    |>Repo.preload(:managee)
  end

  @doc """
  Creates a manage.

  ## Examples

  iex> create_manage(%{field: value})
  {:ok, %Manage{}}

  iex> create_manage(%{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def create_manage(attrs \\ %{}) do
    %Manage{}
    |> Manage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a manage.

  ## Examples

  iex> update_manage(manage, %{field: new_value})
  {:ok, %Manage{}}

  iex> update_manage(manage, %{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def update_manage(%Manage{} = manage, attrs) do
    manage
    |> Manage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Manage.

  ## Examples

  iex> delete_manage(manage)
  {:ok, %Manage{}}

  iex> delete_manage(manage)
  {:error, %Ecto.Changeset{}}

  """
  def delete_manage(%Manage{} = manage) do
    Repo.delete(manage)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking manage changes.

  ## Examples

  iex> change_manage(manage)
  %Ecto.Changeset{source: %Manage{}}

  """
  def change_manage(%Manage{} = manage) do
    Manage.changeset(manage, %{})
  end

  def manages_map_for(user_id) do
    Repo.all(from m in Manage,
    where: m.manager_id == ^user_id)
    |> Enum.map(&({&1.managee_id, &1.managee_id}))
    |> Enum.into(%{})
  end


  alias Tasktrack.Assignments.Time_Block

  @doc """
  Returns the list of time_blocks.

  ## Examples

  iex> list_time_blocks()
  [%Time_Block{}, ...]

  """
  def list_time_blocks do
    Repo.all(Time_Block)
    |>Repo.preload(:for_task)
  end

  @doc """
  Gets a single time__block.

  Raises `Ecto.NoResultsError` if the Time  block does not exist.

  ## Examples

  iex> get_time__block!(123)
  %Time_Block{}

  iex> get_time__block!(456)
  ** (Ecto.NoResultsError)

  """
  def get_time__block!(id) do
    Repo.get!(Time_Block, id)
    |>Repo.preload(:for_task)
  end

  @doc """
  Creates a time__block.

  ## Examples

  iex> create_time__block(%{field: value})
  {:ok, %Time_Block{}}

  iex> create_time__block(%{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def create_time__block(attrs \\ %{}) do
    %Time_Block{}
    |> Time_Block.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a time__block.

  ## Examples

  iex> update_time__block(time__block, %{field: new_value})
  {:ok, %Time_Block{}}

  iex> update_time__block(time__block, %{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def update_time__block(%Time_Block{} = time__block, attrs) do
    time__block
    |> Time_Block.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Time_Block.

  ## Examples

  iex> delete_time__block(time__block)
  {:ok, %Time_Block{}}

  iex> delete_time__block(time__block)
  {:error, %Ecto.Changeset{}}

  """
  def delete_time__block(%Time_Block{} = time__block) do
    Repo.delete(time__block)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking time__block changes.

  ## Examples

  iex> change_time__block(time__block)
  %Ecto.Changeset{source: %Time_Block{}}

  """
  def change_time__block(%Time_Block{} = time__block) do
    Time_Block.changeset(time__block, %{})
  end
end
