defmodule Phapi.User do
	use Phapi.Web, :model

	schema "users" do
		field :email, :string
    field :password, :string,               virtual: true
    field :password_hash, :string

    field :role, :string,                   default: "basic",    null: false
    field :reset_password_token, :string
    field :reset_password_sent_at, Ecto.DateTime
    field :sign_in_count, :integer,         default: 0,     null: false
    field :current_sign_in_at, Ecto.DateTime
    field :last_sign_in_at, Ecto.DateTime

    field :confirmation_token, :string
    field :confirmed_at, Ecto.DateTime
    field :unconfirmed_email, :string

		timestamps()
	end

	@required_fields ~w(email)
  @optional_fields ~w(password role reset_password_token reset_password_sent_at sign_in_count current_sign_in_at
                      last_sign_in_at confirmation_token confirmed_at unconfirmed_email)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> validate_user params
  end

  def registration_changeset(struct, params \\ %{}) do
    changeset(struct, params)
    |> validate_required([:password])
  end

  def validate_user(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> hash_password
  end

  defp hash_password(changeset) do
    if password = get_change(changeset, :password) do
      changeset
      |> validate_length(:password, min: 5, max: 50)
      |> put_change(:password_hash, Comeonin.Bcrypt.hashpwsalt(password))
    else
      changeset
    end
  end
end
