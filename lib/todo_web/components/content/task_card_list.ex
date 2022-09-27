defmodule TodoWeb.Components.Content.TaskCardList do
  @moduledoc false

  use TodoWeb, :component

  attr :tasks, :list
  attr :filter_clioked, :atom

  import TodoWeb.Components.Content.Task
  import TodoWeb.Components.Content.TaskCardList.ActionsAndFilters

  def task_card_list(assigns) do
    ~H"""
    <div class={"task-card-list-#{@color_mode}"}>
      <%= if Enum.count(@tasks) > 0 do %>
        <%= for task <- @tasks do %>
          <.task_card id={task.id} status={task.status} color_mode={@color_mode}>
            <%= task.description %>
          </.task_card>
        <% end %>
      <% else %>
        <.empty_task_card color_mode={@color_mode}>
          Oops... Nothing to show!
        </.empty_task_card>
      <% end %>

      <.actions_and_filters filter_clicked={@filter_clioked} color_mode={@color_mode} tasks={@tasks} />
    </div>
    """
  end
end
