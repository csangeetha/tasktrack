defmodule Tasktrack.Assignments.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktrack.Assignments.Task


  schema "tasks" do
    field :description, :string
    field :status, :boolean, default: false
    field :time_taken, :time, default: '00:00:00'
    field :title, :string
    belongs_to :assigned_to, Tasktrack.Accounts.User
    belongs_to :assigned_by, Tasktrack.Accounts.User
    has_many :time_blocks, Tasktrack.Assignments.Time_Block , foreign_key: :for_task_id

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :time_taken, :status, :assigned_by_id, :assigned_to_id ])
    |> validate_required([:title, :description, :time_taken, :status, :assigned_by_id, :assigned_to_id])
  end
end
