defmodule Todo.Todos do
  alias Todo.Repo
  alias Todo.Todos.Todo

  def get_todo(id) do
    Repo.get(Todo, id)
  end

  def get_all_todos(user_id) do
    import Ecto.Query

    query =
      from(
        t in Todo,
        where: t.user_id == ^user_id,
        select: t
      )

    Repo.all(query)
  end

  def save(params) do
    %Todo{}
    |> Todo.changeset(params)
    |> Repo.insert!()
  end

  def delete(id) do
    %Todo{id: id}
    |> Repo.delete()
  end
end
