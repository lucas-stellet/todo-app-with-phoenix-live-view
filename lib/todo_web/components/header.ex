defmodule TodoWeb.Components.Header do
  use TodoWeb, :live_component

  def render(assigns) do
    assigns = set_classes(assigns)

    ~H"""
    <header>
      <div class={@classes.background}></div>
    </header>
    """
  end
end
