defmodule TodoWeb.Components.Content.Panel do
  use TodoWeb, :component

  attr :toggle, :string

  def panel(assigns) do
    ~H"""
    <div class="panel">
      <img src="/images/logo.png" class="" />
      <button phx-hook="UpdateColorMode" id="colorMode">
        <img src={@toggle} />
      </button>
    </div>
    """
  end
end
