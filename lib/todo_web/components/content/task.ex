defmodule TodoWeb.Components.Content.Task do
  use TodoWeb, :component

  attr :button, :string
  attr :input, :string
  attr :card, :string
  attr :id, :string
  attr :status, :string

  slot(:inner_block, required: false)

  def task_card(assigns) do
    ~H"""
    <div class={@card}>
      <div class="p-4">
        <%= case @status do %>
          <% :completed -> %>
            <button
              phx-click="toggle_task_status"
              value={"#{@id}||#{@status}"}
              class={"#{@button}-checked"}
            >
            </button>
          <% _ -> %>
            <button phx-click="toggle_task_status" value={"#{@id}||#{@status}"} class={@button}>
            </button>
        <% end %>
      </div>

      <div class={@input}>
        <p><%= render_slot(@inner_block) %></p>
      </div>

      <div class="p-4">
        <button phx-click="delete_task" value={@id}>
          <Heroicons.LiveView.icon name="x-mark" type="outline" class="h-7 w-7" />
        </button>
      </div>
    </div>
    """
  end

  def task_input_card(assigns) do
    ~H"""
    <div class={"task-input-card-#{@color_mode}"}>
      <div class="p-4">
        <button class={"task-btn-#{@color_mode}"}></button>
      </div>

      <form phx-submit="create_task" class="flex-1">
        <input
          id="task-input"
          class={"task-input-input-#{@color_mode} focus:ring-0"}
          type="text"
          name="description"
          placeholder="Create a new todo..."
        />
      </form>
    </div>
    """
  end

  def empty_task_card(assigns) do
    ~H"""
    <div class={@card}>
      <div class={"#{@input} text-center"}>
        <p class="text-[20px]"><%= render_slot(@inner_block) %></p>
      </div>
    </div>
    """
  end
end
