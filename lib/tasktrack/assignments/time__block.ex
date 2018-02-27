defmodule Tasktrack.Assignments.Time_Block do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktrack.Assignments.Time_Block
  alias Tasktrack.Assignments.Task

  schema "time_blocks" do
    field :end_time, :naive_datetime
    field :start_time, :naive_datetime
    belongs_to :for_task, Task

    timestamps()
  end

  @doc false
  def changeset(%Time_Block{} = time__block, attrs) do
    time__block
    |> cast(attrs, [:start_time, :end_time, :for_task_id])
    |> validate_required([:start_time, :end_time, :for_task_id])
  end
end
