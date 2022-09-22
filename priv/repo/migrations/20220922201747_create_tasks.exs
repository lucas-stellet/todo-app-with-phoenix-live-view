defmodule Todo.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :description, :text
      add :status, :string
      add :author, :string

      timestamps()
    end
  end
end
