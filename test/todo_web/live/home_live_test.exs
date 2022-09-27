defmodule TodoWeb.HomeLiveTest do
  use TodoWeb.ConnCase, async: false

  @endpoint TodoWeb.Endpoint

  describe "Initial setup" do
    test "disconnected and connected mount", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 200) =~ "id=\"todo-app\""

      {:ok, _view, _html} = live(conn)
    end

    test "connected mount", %{conn: conn} do
      {:ok, _view, html} = live(conn, "/")
      assert html =~ "id=\"todo-app\""
    end

    test "default assigns", %{conn: conn} do
      conn = get(conn, "/")

      assert nil == conn.assigns.color_mode
      assert [] == conn.assigns.tasks
      assert nil == conn.assigns.user_access_key
      assert :all == conn.assigns.tasks_filter_clicked
    end
  end

  describe "Handle Events" do
    setup [:setup_conn]

    test "update color mode", %{view: view} = ctx do
      create_task(ctx)

      assert view
             |> element("#toggle-color-mode")
             |> render_hook("update_color_mode", %{"colorMode" => "dark"}) =~ "sun.svg"
    end

    test "submit new task", %{view: view} = ctx do
      create_task(ctx)

      assert view
             |> form("#new-task", description: "A new task")
             |> render_submit(%{description: "A new task"}) =~ "A new task"
    end

    test "list all tasks", %{view: view} = ctx do
      create_task(ctx)

      assert view
             |> element("#all-filter")
             |> render_click() =~ "1 items left"
    end

    test "list active tasks", %{view: view} = ctx do
      create_active_tasks(ctx)

      assert view
             |> element("#active-filter")
             |> render_click() =~ "3 items left"
    end

    test "list completed tasks", %{view: view} = ctx do
      create_completed_tasks(ctx)

      assert view
             |> element("#completed-filter")
             |> render_click() =~ "3 items left"
    end

    test "clear completed tasks", %{view: view} = ctx do
      create_completed_tasks(ctx)

      assert view
             |> element("#completed-filter")
             |> render_click() =~ "3 items left"

      assert view
             |> element("#clear-completed")
             |> render_click() =~ "0 items left"
    end
  end
end
