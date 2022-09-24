defmodule TodoWeb.Components.Content.TaskCardList do
  use TodoWeb, :component

  attr :tasks, :list
  attr :card_list, :string
  attr :card, :string
  attr :bottom, :string
  attr :button, :string
  attr :input, :string

  import TodoWeb.Components.Content.TaskCard

  def task_card_list(assigns) do
    ~H"""
    <div class={@card_list}>
      <%= for task <- @tasks do %>
        <.task_card input={@input} card={@card} button={@button}>
          <%= task.description %>
        </.task_card>
      <% end %>
      <div class={@bottom}>
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
