defmodule TodoWeb.Components.Content.TaskInput do
  use TodoWeb, :component

  attr :button, :string

  def task_input(assigns) do
    ~H"""
    <div class="task-card">
      <button class={@button}></button>
      <.form for={:task} phx-submit="create_task">
        <input type="text" name="description" placeholder="Create a new todo..." />
      </.form>
    </div>
    """
  end
end
