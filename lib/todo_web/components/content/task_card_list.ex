defmodule TodoWeb.Components.Content.TaskCardList do
  use TodoWeb, :component

  attr :tasks, :list
  attr :filter_clioked, :string

  import TodoWeb.Components.Content.Task

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

      <.filters_bottom filter_clioked={@filter_clioked} color_mode={@color_mode} tasks={@tasks}>
      </.filters_bottom>
    </div>
    """
  end

  def filters_bottom(assigns) do
    ~H"""
    <div class={"task-card-bottom-#{@color_mode}"}>
      <button class="task-card-bottom-filter">
        <%= Enum.count(@tasks) %> items left
      </button>

      <div class="task-card-bottom-filters">
        <%= case @filter_clioked do %>
          <% :all -> %>
            <button
              phx-hook="SendCurrentFilter"
              id="all-filter"
              class="task-card-bottom-filter-current"
              phx-click="list_all_tasks"
            >
              All
            </button>

            <button
              phx-hook="SendCurrentFilter"
              id="active-filter"
              class="task-card-bottom-filter"
              phx-click="list_active_tasks"
            >
              Active
            </button>

            <button
              phx-hook="SendCurrentFilter"
              id="completed-filter"
              class="task-card-bottom-filter"
              phx-click="list_completed_tasks"
            >
              Completed
            </button>
          <% :active -> %>
            <button
              phx-hook="SendCurrentFilter"
              id="all-filter"
              class="task-card-bottom-filter"
              phx-click="list_all_tasks"
            >
              All
            </button>

            <button
              phx-hook="SendCurrentFilter"
              id="active-filter"
              class="task-card-bottom-filter-current"
              phx-click="list_active_tasks"
            >
              Active
            </button>

            <button
              phx-hook="SendCurrentFilter"
              id="completed-filter"
              class="task-card-bottom-filter"
              phx-click="list_completed_tasks"
            >
              Completed
            </button>
          <% :completed -> %>
            <button
              phx-hook="SendCurrentFilter"
              id="all-filter"
              class="task-card-bottom-filter"
              phx-click="list_all_tasks"
            >
              All
            </button>

            <button
              phx-hook="SendCurrentFilter"
              id="active-filter"
              class="task-card-bottom-filter"
              phx-click="list_active_tasks"
            >
              Active
            </button>

            <button
              phx-hook="SendCurrentFilter"
              id="completed-filter"
              class="task-card-bottom-filter-current"
              phx-click="list_completed_tasks"
            >
              Completed
            </button>
        <% end %>
      </div>
      <button class="task-card-bottom-filter" phx-click="delete_completed_tasks">
        Clear Completed
      </button>
    </div>
    """
  end
end
