defmodule Todo.TasksTest do
  @moduledoc false
  use Todo.DataCase

  alias Todo.Tasks

  import Todo.Factory

  describe "list_tasks_by_author/1" do
    test "returns all tasks related to author" do
      task = insert(:task)

      assert Tasks.list_tasks_by_author(task.author) == [task]
    end

    test "returns an empty array if there is no task related to author" do
      insert(:task)

      assert Tasks.list_tasks_by_author(Ecto.UUID.generate()) == []
    end
  end

  describe "list_tasks_by_status/2" do
    test "returns all tasks related to author with given status" do
      author = Ecto.UUID.generate()

      insert(:task, status: :completed)

      [active_task_1, active_task_2] = insert_list(2, :task, status: :active, author: author)

      assert Tasks.list_tasks_by_status(author, :active) == [active_task_1, active_task_2]
    end

    test "returns an empty array if there is no task related to author and given status" do
      author = Ecto.UUID.generate()

      insert(:task, status: :completed)

      assert Tasks.list_tasks_by_status(author, :active) == []
    end
  end

  describe "delete_completed_tasks/1" do
    test "returns :ok when there is completed tasks" do
      author = Ecto.UUID.generate()

      insert(:task, status: :completed, author: author)

      insert_list(2, :task, status: :active, author: author)

      assert Tasks.delete_completed_tasks(author) == :ok

      assert Enum.count(Tasks.list_tasks_by_status(author, :active)) == 2
    end

    test "returns error tuple when there is completed tasks" do
      author = Ecto.UUID.generate()

      insert_list(2, :task, status: :active, author: author)

      assert Tasks.delete_completed_tasks(author) == {:error, :no_completed_tasks}
    end
  end

  describe "delete_task/2" do
    test "returns :ok when the task has its status changed to deleted" do
      task = insert(:task)

      assert :ok = Tasks.delete_task(task.author, task.id)
    end

    test "returns :error tuple when the task not exists or not belongs to author" do
      task = insert(:task)

      assert {:error, :task_not_found} = Tasks.delete_task(Ecto.UUID.generate(), task.id)
    end
  end

  describe "complete_task/2" do
    test "returns :ok when the task has its status changed to completed" do
      task = insert(:task)

      assert :ok = Tasks.complete_task(task.author, task.id)
    end

    test "returns :error tuple when the task not exists or not belongs to author" do
      task = insert(:task)

      assert {:error, :task_not_found} = Tasks.complete_task(Ecto.UUID.generate(), task.id)
    end
  end

  describe "toggle_task_status/3" do
    test "returns :ok when the task changed its status to completed" do
      task = insert(:task, status: :active)

      assert :ok = Tasks.toggle_task_status(task.author, task.id, to_string(task.status))

      changed_task = Todo.Repo.get(Tasks.Task, task.id)

      assert changed_task.status == :completed
    end

    test "returns :ok when the task changed its status to active" do
      task = insert(:task, status: :completed)

      assert :ok = Tasks.toggle_task_status(task.author, task.id, to_string(task.status))

      changed_task = Todo.Repo.get(Tasks.Task, task.id)

      assert changed_task.status == :active
    end

    test "returns :error tuple when the task not exists or not belongs to author" do
      task = insert(:task)

      assert {:error, :task_not_found} =
               Tasks.toggle_task_status(Ecto.UUID.generate(), task.id, to_string(task.status))
    end
  end

  describe "create_task/1" do
    test "returns a new task" do
      author = Ecto.UUID.generate()
      task_description = Faker.Lorem.sentence(5)

      assert {:ok, %Tasks.Task{description: ^task_description}} =
               Tasks.create_task(%{description: task_description, author: author})
    end
  end
end
