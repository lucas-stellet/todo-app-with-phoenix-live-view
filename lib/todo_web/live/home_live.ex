defmodule TodoWeb.HomeLive do
  use TodoWeb, :live_view

  alias Todo.Tasks

  def render(assigns) do
    ~H"""
    <.live_component module={Header} id="header" color_mode={@color_mode} />

    <.live_component
      module={Content}
      id="content"
      tasks_filter_clicked={@tasks_filter_clicked}
      tasks={@tasks}
      color_mode={@color_mode}
    />
    """
  end

  def mount(_params, _session, socket) do
    {:ok, update_with_default_assigns(socket)}
  end

  def handle_event("update_color_mode", %{"colorMode" => color_mode}, socket) do
    {:noreply, assign(socket, :color_mode, color_mode)}
  end

  def handle_event("create_task", %{"description" => description}, socket) do
    {:ok, _} = Tasks.create_task(%{description: description, author: get_author_identity(socket)})

    tasks = Tasks.list_tasks_by_author(get_author_identity(socket))

    socket = assign(socket, :tasks, tasks)

    {:noreply, socket}
  end

  def handle_event("list_all_tasks", _params, socket) do
    tasks = Tasks.list_tasks_by_author(get_author_identity(socket))

    socket = assign(socket, :tasks, tasks)

    {:noreply, socket}
  end

  def handle_event("list_active_tasks", _params, socket) do
    tasks = Tasks.list_tasks_by_status(get_author_identity(socket), :active)

    socket = assign(socket, :tasks, tasks)

    {:noreply, socket}
  end

  def handle_event("list_completed_tasks", _params, socket) do
    socket =
      assign(socket, :tasks, Tasks.list_tasks_by_status(get_author_identity(socket), :completed))

    {:noreply, socket}
  end

  def handle_event("delete_task", %{"value" => task_id}, socket) do
    Tasks.delete_task(get_author_identity(socket), task_id)

    tasks = Tasks.list_tasks_by_author(get_author_identity(socket))

    socket = assign(socket, :tasks, tasks)

    {:noreply, socket}
  end

  def handle_event("delete_completed_tasks", _params, socket) do
    author = get_author_identity(socket)
    Tasks.delete_completed_tasks(author)

    update_component(:content, tasks: Tasks.list_tasks_by_author(author))

    {:noreply, socket}
  end

  def handle_event("toggle_task_status", %{"value" => value}, socket) do
    author = socket.assigns.user_access_key

    [task_id, current_state] = String.split(value, "||")

    Tasks.toggle_task_status(author, task_id, current_state)

    update_component(:content, tasks: Tasks.list_tasks_by_author(author))

    {:noreply, socket}
  end

  def handle_event("change-active-filter", %{"filterClicked" => filterClicked}, socket) do
    update_component(:content, tasks_filter_clicked: String.to_existing_atom(filterClicked))

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
    |> assign(:tasks_filter_clicked, :all)
  end

  defp get_author_identity(socket), do: socket.assigns.user_access_key
end
