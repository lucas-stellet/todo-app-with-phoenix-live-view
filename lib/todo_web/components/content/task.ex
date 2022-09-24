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

      <%= if Enum.count(@inner_block) > 0  do %>
        <div class={@input}>
          <p><%= render_slot(@inner_block) %></p>
        </div>
      <% else %>
        <form phx-submit="create_task" class="flex-1">
          <input class={@input} type="text" name="description" placeholder="Create a new todo..." />
        </form>
      <% end %>
    </div>
    """
  end

  def task_input_card(assigns) do
    ~H"""
    <div class={@card}>
      <div class="p-4">
        <button class={@button}></button>
      </div>

      <form phx-submit="create_task" class="flex-1">
        <input
          id="task-input"
          class={@input}
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

# <input
# class={@input}
# type="text"
# name="description"
# value={render_slot(@inner_block)}
# disabled={false}
# />