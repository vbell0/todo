defmodule TodoWeb.HomeLive do
  alias Todo.Todos
  use TodoWeb, :live_view

  def mount(_params, _session, socket) do
    changeset = Todo.Todos.Todo.changeset(%Todo.Todos.Todo{})

    socket =
      assign(socket,
        changeset: changeset,
        trigger_submit: false,
        todos: todos(socket)
      )

    {:ok, socket, temporary_assigns: [changeset: nil]}
  end

  def handle_event("valide", %{"todo" => todo}, socket) do
    changeset = Todo.Todos.Todo.changeset(%Todo.Todos.Todo{}, todo)
    {:noreply, assign(socket, changeset: Map.put(changeset, :action, :validate))}
  end

  def handle_event("delete", %{"value" => todo_id}, socket) do
    Todos.delete(todo_id)
    socket = assign(socket, todos: todos(socket))
    {:noreply, socket}
  end

  def handle_event("add_todo", %{"todo" => todo}, socket) do
    Todos.save(todo)

    socket =
      assign(
        socket,
        todos: todos(socket)
      )

    {:noreply, socket}
  end

  def handle_event(event, _, socket) do
    IO.inspect(event)

    {:noreply, socket}
  end

  defp todos(socket) do
    user_id = socket.assigns.current_user.id

    Todos.get_all_todos(user_id)
    |> Enum.sort_by(& &1.inserted_at, :asc)
    |> Enum.reverse()
  end
end
