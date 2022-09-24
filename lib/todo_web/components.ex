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
    is_checked? = false

    checked =
      if is_checked? == true do
        "checked-#{color_mode}"
      else
        "#{color_mode}"
      end

    classes = %{
      background: "bkg-#{color_mode}",
      task_text: "task-text#{checked}",
      task_button: "task-btn-#{checked}",
      task_input_card: "task-input-card-#{color_mode}",
      task_input_input: "task-input-input-#{color_mode} focus:ring-0",
      task_card: "task-card-#{color_mode}",
      task_card_list: "task-card-list-#{color_mode}",
      task_card_bottom: "task-card-bottom-#{color_mode}"
    }

    Logger.debug("""
    Color mode configugrations
      #{inspect(classes)}
    """)

    assigns
    |> Phoenix.Component.assign(:classes, classes)
    |> Phoenix.Component.assign(:color_mode, color_mode)
  end
end
