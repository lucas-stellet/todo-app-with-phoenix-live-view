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
end
