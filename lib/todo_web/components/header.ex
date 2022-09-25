defmodule TodoWeb.Components.Header do
  use TodoWeb, :live_component

  def render(assigns) do
    ~H"""
    <header>
      <div class={"#{@color_mode}-background"}></div>
    </header>
    """
  end
end
