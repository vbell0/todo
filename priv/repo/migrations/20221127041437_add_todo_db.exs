defmodule Todo.Repo.Migrations.AddTodoDb do
  use Ecto.Migration

  def change do
    create table(:todos, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      add :title, :string, null: false
      add :done, :boolean, null: false
      add :cancel, :boolean, null: false
      add :trash, :boolean, null: false
      timestamps()
    end
  end
end
