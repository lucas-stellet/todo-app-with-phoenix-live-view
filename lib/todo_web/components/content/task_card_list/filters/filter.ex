defmodule TodoWeb.Components.Content.TaskCardList.Filters.Filter do
  @moduledoc false

  use TodoWeb, :component

  attr :filter_clicked, :boolean
  attr :type, :string

  slot(:inner_block, required: true)

  def filter(%{filter_clicked: true} = assigns) do
    ~H"""
    <button
      phx-hook="SendCurrentFilter"
      id={"#{@type}-filter"}
      class="task-card-bottom-filter-current"
      phx-click={"list_#{@type}_tasks"}
    >
      <%= render_slot(@inner_block) %>
    </button>
    """
  end

  def filter(assigns) do
    ~H"""
    <button
      phx-hook="SendCurrentFilter"
      id={"#{@type}-filter"}
      class="task-card-bottom-filter"
      phx-click={"list_#{@type}_tasks"}
    >
      <%= render_slot(@inner_block) %>
    </button>
    """
  end
end
