defmodule TodoWeb.Components.Content.TaskCardList.Filters do
  @moduledoc false

  use TodoWeb, :component

  attr :filter_clicked, :atom

  import TodoWeb.Components.Content.TaskCardList.Filters.Filter

  def filters(assigns) do
    ~H"""
    <%= case @filter_clicked do %>
      <% :all -> %>
        <.filter filter_clicked={true} type="all">
          All
        </.filter>

        <.filter filter_clicked={false} type="active">
          Active
        </.filter>

        <.filter filter_clicked={false} type="completed">
          Completed
        </.filter>
      <% :active -> %>
        <.filter filter_clicked={false} type="all">
          All
        </.filter>

        <.filter filter_clicked={true} type="active">
          Active
        </.filter>

        <.filter filter_clicked={false} type="completed">
          Completed
        </.filter>
      <% :completed -> %>
        <.filter filter_clicked={false} type="all">
          All
        </.filter>

        <.filter filter_clicked={false} type="active">
          Active
        </.filter>

        <.filter filter_clicked={true} type="completed">
          Completed
        </.filter>
    <% end %>
    """
  end
end
