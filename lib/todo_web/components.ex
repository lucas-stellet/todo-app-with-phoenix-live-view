defmodule TodoWeb.Components do
  defmacro __using__(_) do
    quote do
      alias TodoWeb.Components.Header
    end
  end
end
