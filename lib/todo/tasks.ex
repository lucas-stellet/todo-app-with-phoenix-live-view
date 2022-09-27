defmodule Todo.Tasks do
  @moduledoc """
  The Tasks context.
  """

  import Ecto.Query, warn: false
  alias Todo.Repo

  alias Todo.Tasks.Task

  @doc """
  Returns tasks from author..

  ## Examples

  iex> list_tasks_by_author("author")
  [%Task{}, ...]

  iex> list_tasks_by_author("unknown author")
  nil

  """

  @spec list_tasks_by_author(Ecto.UUID.t()) :: [Task.t()] | nil
  def list_tasks_by_author(author) do
    query =
      from t in Task,
        where: t.author == ^author and t.status != :deleted,
        order_by: [asc: t.inserted_at],
        select: t

    Repo.all(query)
  end

  @doc """
  Returns tasks bases on status.

  ## Examples

  iex> list_tasks_by_status("author", "status")
  [%Task{}, ...]

  iex> list_tasks_by_status("author", "uunknown status")
  nil

  """

  @spec list_tasks_by_status(Ecto.UUID.t(), atom()) :: [Task.t()] | nil
  def list_tasks_by_status(author, status) do
    query =
      from t in Task,
        where: t.author == ^author and t.status == ^status,
        order_by: [asc: t.inserted_at],
        select: t

    Repo.all(query)
  end

  @doc """
  Change status `:completed` from completed to `:deleted`

  ## Examples

  iex> delete_completed_tasks("author")
  [%Task{}, ...]

  """

  @spec delete_completed_tasks(Ecto.UUID.t()) :: :ok | {:error, atom()}
  def delete_completed_tasks(author) do
    query =
      from t in Task,
        where: t.author == ^author and t.status == :completed,
        select: t

    case Repo.update_all(query, set: [status: :deleted]) do
      {_, [%Task{} | _]} ->
        :ok

      {0, []} ->
        {:error, :no_completed_tasks}
    end
  end

  @spec delete_task(Ecto.UUID.t(), Ecto.UUID.t()) :: :ok | {:error, atom()}
  def delete_task(author, task_id) do
    query =
      from t in Task,
        where: t.author == ^author and t.id == ^task_id,
        select: t

    case Repo.update_all(query, set: [status: :deleted]) do
      {1, [%Task{id: ^task_id}]} ->
        :ok

      {0, []} ->
        {:error, :task_not_found}
    end
  end

  @doc """
  Change task status to completed.

  ## Examples

      iex> complete_task("author_id", "task_id")
      {:ok}

      iex> complete_task("author_id", "wrong_task_is")
      {:error, :task_not_found}

  """

  @spec complete_task(Ecto.UUID.t(), Ecto.UUID.t()) :: :ok | {:error, atom()}
  def complete_task(author, task_id) do
    query =
      from t in Task,
        where: t.author == ^author and t.id == ^task_id,
        select: t

    Repo.update_all(query, set: [status: :completed])
  end

  @doc """
  Change task status between completed and active.

  ## Examples

      iex> toggle_task_status("author_id", "task_id", "active" | "completed")
      {:ok}

      iex> toggle_task_status("author_id", "wrong_task_is", "wrong_status")
      {:error, :task_not_found}

  """
  @spec toggle_task_status(Ecto.UUID.t(), Ecto.UUID.t(), binary()) :: :ok | {:error, atom()}
  def toggle_task_status(author, task_id, "active") do
    query =
      from t in Task,
        where: t.author == ^author and t.id == ^task_id,
        select: t

    case Repo.update_all(query, set: [status: :completed]) do
      {1, [%Task{id: ^task_id}]} ->
        :ok

      {0, []} ->
        {:error, :task_not_found}
    end
  end

  def toggle_task_status(author, task_id, "completed") do
    query =
      from t in Task,
        where: t.author == ^author and t.id == ^task_id,
        select: t

    case Repo.update_all(query, set: [status: :active]) do
      {1, [%Task{id: ^task_id}]} ->
        :ok

      {0, []} ->
        {:error, :task_not_found}
    end
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
