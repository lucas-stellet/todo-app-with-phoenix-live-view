defmodule Todo.Factory do
  use ExMachina.Ecto, repo: Todo.Repo

  alias Todo.Tasks.Task

  def task_factory() do
    %Task{
      id: Ecto.UUID.generate(),
      description: Faker.Lorem.sentence(10),
      author: Ecto.UUID.generate(),
      status: :active
    }
  end
end
