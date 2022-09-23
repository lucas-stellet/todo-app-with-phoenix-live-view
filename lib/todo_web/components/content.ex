defmodule TodoWeb.Components.Content do
  use TodoWeb, :live_component

  import __MODULE__.{Panel, TaskCard, TaskInput}

  attr :tasks, :list

  attr :task, :map

  def render(assigns) do
    assigns = set_classes(assigns)

    ~H"""
    <div class="content">
      <.panel toggle={@classes.toggle} />
      <.task_input
        button={@classes.task_button}
        input={@classes.task_input_input}
        card={@classes.task_input_card}
      />

      <%= for task <- @tasks do %>
        <.task_card task_card={@classes.task_card}>
          <%= task.description %>
        </.task_card>
      <% end %>
    </div>
    """
  end
end
