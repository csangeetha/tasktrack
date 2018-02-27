defmodule Tasktrack.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktrack.Accounts.User
  alias Tasktrack.Assignments.Manage

  schema "users" do
    field :email, :string
    field :name, :string
    has_many :manager_manages, Manage, foreign_key: :manager_id
    has_one :managee_manages, Manage, foreign_key: :managee_id
    has_one :manager, through: [:managee_manages, :manager]
    has_many :managees, through: [:manager_manages, :managee]
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name ])
    |> validate_required([:email, :name])
  end
end
