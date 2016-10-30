defmodule Phapi.Session do
  use Phapi.Web, :model

  schema "sessions" do
    belongs_to :user, Phapi.User

    field :token, :string
    field :remember_for_mins, :integer,         default: 60*24*30,     null: false
    field :remember_created_at, Ecto.DateTime

    timestamps()
  end

  @required_fields ~w(user_id)
  @optional_fields ~w()

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
  end

  def create_changeset(struct, params \\ :empty) do
    changeset(struct, params)
    |> put_change(:token, Phoenix.Token.sign(DockiPhix.Endpoint, "user", :user_id))
  end

  def find_by_user_id(user_id) do
    from session in __MODULE__,
    where: session.user_id == ^user_id
  end
end
