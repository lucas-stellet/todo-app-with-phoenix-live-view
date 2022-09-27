defmodule TodoWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use TodoWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import TodoWeb.ConnCase
      import Phoenix.LiveViewTest

      alias TodoWeb.Router.Helpers, as: Routes

      import Todo.Factory

      # The default endpoint for testing
      @endpoint TodoWeb.Endpoint

      def setup_conn(ctx, opts \\ []) do
        connected_params = %{
          "userAccessKey" => Ecto.UUID.generate(),
          "colorMode" => Keyword.get(opts, :color_mode, "light")
        }

        conn = Phoenix.LiveViewTest.put_connect_params(ctx.conn, connected_params)

        {:ok, view, _html} = live(conn, "/")

        ctx =
          ctx
          |> Map.put(:conn, conn)
          |> Map.put(:user_access_key, connected_params["userAccessKey"])
          |> Map.put(:view, view)

        {:ok, ctx}
      end

      def create_task(%{user_access_key: author} = ctx), do: insert(:task, author: author)

      def create_active_tasks(%{user_access_key: author} = ctx),
        do: insert_list(3, :task, author: author)

      def create_mixed_tasks(%{user_access_key: author} = ctx),
        do: insert_list(3, :task, author: author)

      def create_completed_tasks(%{user_access_key: author} = ctx),
        do: insert_list(3, :task, author: author, status: :completed)
    end
  end

  setup tags do
    Todo.DataCase.setup_sandbox(tags)
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
