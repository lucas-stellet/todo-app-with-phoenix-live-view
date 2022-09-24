defmodule TodoWeb.HomeLive do
  use TodoWeb, :live_view

  alias Todo.Tasks

  def render(assigns) do
    ~H"""
    <.live_component module={Header} id="header" color_mode={@color_mode} />

    <.live_component module={Content} id="content" tasks={@tasks} color_mode={@color_mode} />
    """
  end

  def mount(_params, _session, socket) do
    {:ok, update_with_default_assigns(socket)}
  end

  def handle_event("update_color_mode", %{"colorMode" => color_mode}, socket) do
    update_component(:all, color_mode: color_mode)

    {:noreply, socket}
  end

  def handle_event("list_all_tasks", _params, socket) do
    author = socket.assigns.user_access_key

    update_component(:content, tasks: Tasks.list_tasks_by_author(author))

    {:noreply, socket}
  end

  def handle_event("list_active_tasks", _params, socket) do
    author = get_author_identity(socket)

    update_component(:content, tasks: Tasks.list_tasks_by_status(author, :active))

    {:noreply, socket}
  end

  def handle_event("list_completed_tasks", _params, socket) do
    author = get_author_identity(socket)

    update_component(:content, tasks: Tasks.list_tasks_by_status(author, :completed))

    {:noreply, socket}
  end

  def handle_event("delete_completed_tasks", _params, socket) do
    author = get_author_identity(socket)
    Tasks.delete_completed_tasks(author)

    update_component(:content, tasks: Tasks.list_tasks_by_author(author))

    {:noreply, socket}
  end

  def handle_event("create_task", %{"description" => description}, socket) do
    author = socket.assigns.user_access_key
    {:ok, _} = Tasks.create_task(%{description: description, author: author})

    update_component(:content, tasks: Tasks.list_tasks_by_author(author))

    {:noreply, socket}
  end

  defp update_with_default_assigns(socket) do
    color_mode = get_connect_params(socket)["colorMode"]
    user_access_key = get_connect_params(socket)["userAccessKey"]

    tasks =
      if is_nil(user_access_key) do
        []
      else
        Tasks.list_tasks_by_author(user_access_key)
      end

    socket
    |> assign(:color_mode, color_mode)
    |> assign(:tasks, tasks)
    |> assign(:user_access_key, user_access_key)
  end

  defp get_author_identity(socket), do: socket.assigns.user_access_key
end
