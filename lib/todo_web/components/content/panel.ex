defmodule TodoWeb.Components.Content.Panel do
  use TodoWeb, :component

  def panel(assigns) do
    ~H"""
    <div class="panel">
      <img src="/images/logo.png" class="" />
      <button phx-hook="UpdateColorMode" id="colorMode">
        <%= if @color_mode == "dark" do %>
          <img src="/images/sun.svg" />
        <% else %>
          <img src="/images/moon.svg" />
        <% end %>
      </button>
    </div>
    """
  end
end
