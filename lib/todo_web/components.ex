defmodule TodoWeb.Components do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      alias TodoWeb.Components.{Content, Header}
    end
  end
end
