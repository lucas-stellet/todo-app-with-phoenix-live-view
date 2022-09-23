defmodule TodoWeb.Components.Content.TaskCard do
  use TodoWeb, :component

  attr :button, :string
  attr :input, :string
  attr :card, :string

  slot(:inner_block, required: false)

  def task_card(assigns) do
    ~H"""
    <div class={@card}>
      <div class="p-4">
        <button class={@button}></button>
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
end

# <input
# class={@input}
# type="text"
# name="description"
# value={render_slot(@inner_block)}
# disabled={false}
# />
