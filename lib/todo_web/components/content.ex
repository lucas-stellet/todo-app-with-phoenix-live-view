defmodule TodoWeb.Components.Content do
  use TodoWeb, :live_component

  import __MODULE__.{Panel, TaskCardList, TaskCard}

  attr :tasks, :list

  attr :task, :map

  def render(assigns) do
    assigns = set_classes(assigns)

    ~H"""
    <div class="content">
      <.panel toggle={@classes.toggle} />
      <.task_card
        button={@classes.task_button}
        input={@classes.task_input_input}
        card={@classes.task_input_card}
      />

      <.task_card_list
        tasks={@tasks}
        card_list={@classes.task_card_list}
        card={@classes.task_card}
        bottom={@classes.task_card_bottom}
        button={@classes.task_button}
        input={@classes.task_input_input}
      />
    </div>
    """
  end
end
