defmodule Tasktrack.Assignments.Manage do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktrack.Assignments.Manage
  alias Tasktrack.Accounts.User

  schema "manages" do
    belongs_to :managee, User
    belongs_to :manager, User

    timestamps()
  end

  @doc false
  def changeset(%Manage{} = manage, attrs) do
    manage
    |> cast(attrs, [:managee_id, :manager_id])
    |> validate_required([:managee_id, :manager_id])
  end
end
