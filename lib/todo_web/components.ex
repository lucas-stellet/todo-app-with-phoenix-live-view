defmodule TodoWeb.Components do
  defmacro __using__(_) do
    quote do
      alias TodoWeb.Components.{Content, Header}
    end
  end
end
