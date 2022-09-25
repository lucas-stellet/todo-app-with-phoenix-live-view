defmodule TodoWeb.Components.Content.Task do
  use TodoWeb, :component

  attr :card, :string
  attr :id, :string
  attr :status, :string

  slot(:inner_block, required: false)

  def task_card(assigns) do
    ~H"""
    <div class={"task-card-#{@color_mode}"}>
      <div class="p-4">
        <%= case @status do %>
          <% :completed -> %>
            <button
              phx-click="toggle_task_status"
              value={"#{@id}||#{@status}"}
              class={"task-btn-#{@color_mode}-checked"}
            >
              <Heroicons.LiveView.icon
                name="check"
                type="solid"
                class="h-4 w-4 font-bold text-slate-50 m-auto"
              />
            </button>
          <% _ -> %>
            <button
              phx-click="toggle_task_status"
              value={"#{@id}||#{@status}"}
              class={"task-btn-#{@color_mode}"}
            >
            </button>
        <% end %>
      </div>

      <div class={"task-input-input-#{@color_mode} "}>
        <p><%= render_slot(@inner_block) %></p>
      </div>

      <div class="p-4">
        <button phx-click="delete_task" value={@id}>
          <Heroicons.LiveView.icon
            name="x-mark"
            type="outline"
            class={"h-7 w-7 text-#{@color_mode}-mode-x-mark"}
          />
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
    <div class={"task-card-#{@color_mode}"}>
      <div class={"task-input-input-#{@color_mode} text-center"}>
        <p class="text-[20px]"><%= render_slot(@inner_block) %></p>
      </div>
    </div>
    """
  end
end
