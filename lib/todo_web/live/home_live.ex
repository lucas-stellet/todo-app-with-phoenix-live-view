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

  def handle_event("create_task", %{"description" => description}, socket) do
    {:ok, _} = Tasks.create_task(%{description: description})

    update_component(:content, tasks: Tasks.list_tasks())

    {:noreply, socket}
  end

  defp update_with_default_assigns(socket) do
    color_mode = get_connect_params(socket)["colorMode"]
    tasks = Tasks.list_tasks()

    socket
    |> assign(:color_mode, color_mode)
    |> assign(:tasks, tasks)
  end
end
