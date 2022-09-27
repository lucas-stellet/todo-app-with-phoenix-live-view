defmodule TodoWeb.Components.Content.TaskCardList.ActionsAndFilters do
  @moduledoc false

  use TodoWeb, :component

  attr :filter_clicked, :atom
  attr :tasks, :list

  import TodoWeb.Components.Content.TaskCardList.Filters

  def actions_and_filters(assigns) do
    ~H"""
    <div class={"task-card-bottom-#{@color_mode}"}>
      <%= if Enum.count(@tasks) <= 1 do %>
        <button class="task-card-bottom-filter" disabled>
          <%= Enum.count(@tasks) %> item left
        </button>
      <% else %>
        <button class="task-card-bottom-filter" disabled>
          <%= Enum.count(@tasks) %> items left
        </button>
      <% end %>

      <div class="task-card-bottom-filters">
        <.filters filter_clicked={@filter_clicked} />
      </div>
      <%= if Enum.count(@tasks) > 0 and Enum.any?(@tasks, & &1.status == :completed) do %>
        <button
          class="task-card-bottom-filter"
          id="clear-completed"
          phx-click="delete_completed_tasks"
        >
          Clear Completed
        </button>
      <% else %>
        <button
          class="task-card-bottom-filter"
          id="clear-completed"
          phx-click="delete_completed_tasks"
          disabled
        >
          Clear Completed
        </button>
      <% end %>
    </div>
    """
  end
end
