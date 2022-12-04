defmodule Todo.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  alias Todo.Accounts.User

  @params [:title, :done, :cancel, :trash, :user_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "todos" do
    field :title, :string
    field :done, :boolean, default: false
    field :cancel, :boolean, default: false
    field :trash, :boolean, default: false
    belongs_to :user, User

    timestamps()
  end

  def changeset(todo, attrs \\ %{}) do
    todo
    |> cast(attrs, @params)
    |> validate_length(:title, min: 1, max: 100)
  end
end
