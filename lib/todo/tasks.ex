defmodule Todo.Tasks do
  @moduledoc """
  The Tasks context.
  """

  import Ecto.Query, warn: false
  alias Todo.Repo

  alias Todo.Tasks.Task

  @doc """
  Returns the list of tasks.

  ## Examples

  iex> list_tasks()
  [%Task{}, ...]

  """

  def list_tasks_by_author(author) do
    query =
      from t in Task,
        where: t.author == ^author and t.status != :deleted,
        order_by: [asc: t.inserted_at],
        select: t

    Repo.all(query)
  end

  def list_tasks_by_status(author, status) do
    query =
      from t in Task,
        where: t.author == ^author and t.status == ^status,
        order_by: [asc: t.inserted_at],
        select: t

    Repo.all(query)
  end

  def delete_completed_tasks(author) do
    query =
      from t in Task,
        where: t.author == ^author and t.status == :completed,
        select: t

    Repo.update_all(query, set: [status: :deleted])
  end

  def complete_task(author, task_id) do
    query =
      from t in Task,
        where: t.author == ^author and t.id == ^task_id,
        select: t

    Repo.update_all(query, set: [status: :completed])
  end

  def toggle_task_status(author, task_id, "active") do
    query =
      from t in Task,
        where: t.author == ^author and t.id == ^task_id,
        select: t

    Repo.update_all(query, set: [status: :completed])
  end

  def toggle_task_status(author, task_id, "completed") do
    query =
      from t in Task,
        where: t.author == ^author and t.id == ^task_id,
        select: t

    Repo.update_all(query, set: [status: :active])
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
  Deletes a task.

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
      %Ecto.Changeset{data: %Task{}}

  """
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end
end
