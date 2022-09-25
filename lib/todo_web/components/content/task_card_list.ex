defmodule TodoWeb.Components.Content.TaskCardList do
  use TodoWeb, :component

  attr :tasks, :list

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

      <div class={"task-card-bottom-#{@color_mode}"}>
        <button class="text-dark-mode-bottom-text text-[14px] font-bold">
          <%= Enum.count(@tasks) %> items left
        </button>

        <div class="mx-2 flex-1 flex justify-evenly">
          <button class="text-dark-mode-bottom-text text-[14px] font-bold" phx-click="list_all_tasks">
            All
          </button>

          <button
            class="text-dark-mode-bottom-text text-[14px] font-bold"
            phx-click="list_active_tasks"
          >
            Active
          </button>

          <button
            class="text-dark-mode-bottom-text text-[14px] font-bold"
            phx-click="list_completed_tasks"
          >
            Completed
          </button>
        </div>
        <button
          class="font-bold text-dark-mode-bottom-text text-[14px]"
          phx-click="delete_completed_tasks"
        >
          Clear Completed
        </button>
      </div>
    </div>
    """
  end
end
