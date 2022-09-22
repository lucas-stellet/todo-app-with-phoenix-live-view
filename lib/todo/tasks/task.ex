defmodule Todo.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tasks" do
    field :author, :string
    field :description, :string
    field :status, Ecto.Enum, values: [:active, :completed]

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:description, :status, :author])
    |> validate_required([:description, :status, :author])
  end
end
