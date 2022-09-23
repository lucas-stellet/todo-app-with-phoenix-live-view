defmodule TodoWeb.Components.Content.TaskCard do
  use TodoWeb, :component

  attr :task_card, :string

  slot(:inner_block, required: true)

  def task_card(assigns) do
    ~H"""
    <div class="m-3">
      <h1>
        <%= render_slot(@inner_block) %>
      </h1>
    </div>
    """
  end
end
