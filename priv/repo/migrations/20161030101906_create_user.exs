defmodule Phapi.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
    	add :email, :string
      add :password_hash, :string

      add :role, :string,                   default: "basic",    null: false
      add :reset_password_token, :string
      add :reset_password_sent_at, :datetime
      add :sign_in_count, :integer,         default: 0,     null: false
      add :current_sign_in_at, :datetime
      add :last_sign_in_at, :datetime

      add :confirmation_token, :string
      add :confirmed_at, :datetime
      add :unconfirmed_email, :string

      timestamps()
    end

    create index(:users, [:email], unique: true)
    create unique_index(:users, [:password_hash])
    create unique_index(:users, [:role])

  end
end
