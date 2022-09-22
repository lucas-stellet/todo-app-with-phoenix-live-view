defmodule TodoWeb.Components.Header do
  use Phoenix.LiveComponent

  attr :color_mode, :string

  def render(assigns) do
    color_mode = assigns_to_attributes(assigns)[:color_mode]
    assigns = assign(assigns, :color_mode, "bkg is-#{color_mode}")

    ~H"""
    <header>
      <div class={@color_mode}></div>
    </header>
    """
  end
end
