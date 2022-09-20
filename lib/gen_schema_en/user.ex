defmodule GenSchemaEn.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias GenSchemaEn.Team

  alias GenSchemaEn.UserTeam

  @fields [:email, :first_name, :lastname]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :first_name, :string
    field :lastname, :string
    has_many  :teams, Team
    many_to_many :userteams, Team, join_through: UserTeam, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> cast_assoc(:teams, with: &Team.changeset/2)
    |> unique_constraint(:email)
  end

  def user_belongs_teams(user, teams) do
    user
    |> cast(%{}, @fields)
    |> put_assoc(:userteams, teams)
  end
end
