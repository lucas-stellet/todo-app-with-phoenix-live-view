defmodule TodoWeb.Components.Content.TaskInput do
  use TodoWeb, :component

  attr :button, :string

  def task_input(assigns) do
    ~H"""
    <div class="task-card">
      <button class={@button}></button>
      <%= f =
        form_for(:task, "#",
          id: "task-form",
          phx_submit: "save"
        ) %>
      <%= text_input(f, :description) %>

      <.form for={:task} phx-submit="create_task">
        <input type="text" name="" value="" placeholder="" />
      </.form>
    </div>
    """
  end
end
