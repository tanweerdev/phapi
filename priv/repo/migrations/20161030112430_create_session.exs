defmodule Phapi.Repo.Migrations.CreateSession do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :user_id, references(:users, on_delete: :nothing)
      add :token, :string
      add :remember_for_mins, :integer,         default: 60*24*30,     null: false
      add :remember_created_at, :datetime

      timestamps()
    end
    create index(:sessions, [:user_id])

  end
end
