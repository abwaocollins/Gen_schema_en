defmodule GenSchemaEn.Team do
  use Ecto.Schema
  import Ecto.Changeset
  alias GenSchemaEn.Project
  alias GenSchemaEn.User
  alias GenSchemaEn.UserTeam

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "teams" do
    field :name, :string
    field :user_id, :binary_id
    has_many :projects, Project
    many_to_many :userteams, User, join_through: UserTeam, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> cast_assoc(:projects, with: &Project.changeset/2)
  end
end
