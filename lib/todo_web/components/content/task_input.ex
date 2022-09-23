defmodule TodoWeb.Components.Content.TaskInput do
  use TodoWeb, :component

  attr :button, :string
  attr :input, :string
  attr :card, :string

  def task_input(assigns) do
    ~H"""
    <div class={@card}>
      <div class="p-4">
        <button class={@button}></button>
      </div>

      <form phx-submit="create_task" class="flex-1">
        <input class={@input} type="text" name="description" placeholder="Create a new todo..." />
      </form>
    </div>
    """
  end
end
