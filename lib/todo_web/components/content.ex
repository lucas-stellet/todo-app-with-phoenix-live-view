defmodule TodoWeb.Components.Content do
  use TodoWeb, :live_component

  import __MODULE__.{Panel, TaskCardList, Task}

  attr :tasks, :list
  attr :tasks_filter_clicked, :string

  def render(assigns) do
    ~H"""
    <div class="content">
      <.panel color_mode={@color_mode} />
      <.task_input_card color_mode={@color_mode} />

      <.task_card_list tasks={@tasks} filter_clioked={@tasks_filter_clicked} color_mode={@color_mode} />
    </div>
    """
  end
end
