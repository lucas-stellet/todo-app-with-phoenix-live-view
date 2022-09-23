defmodule TodoWeb.Components do
  defmacro __using__(_) do
    quote do
      alias TodoWeb.Components.{Content, Header}

      def update_component(:content, state),
        do: send_update(Content, Keyword.merge([id: "content"], state))

      def update_component(:header, state),
        do: send_update(Header, Keyword.merge([id: "header"], state))

      def update_component(:all, state) do
        send_update(Content, Keyword.merge([id: "content"], state))
        send_update(Header, Keyword.merge([id: "header"], state))
      end
    end
  end

  require Logger

  def set_classes(assigns) do
    color_mode = Phoenix.Component.assigns_to_attributes(assigns)[:color_mode]
    checked = ""

    classes = %{
      background: "bkg-#{color_mode}",
      toggle: "/images/toggle-#{color_mode}.svg",
      task_text: "task-text#{checked}",
      task_button: "task-btn#{checked}",
      task_card: "task-card-#{color_mode}"
    }

    Logger.debug("""
    Color mode configugrations
      #{inspect(classes)}
    """)

    Phoenix.Component.assign(assigns, :classes, classes)
  end
end
