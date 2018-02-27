defmodule TasktrackWeb.TaskController do
  use TasktrackWeb, :controller

  alias Tasktrack.Assignments
  alias Tasktrack.Assignments.Task

  def index(conn, _params) do
    current_user = conn.assigns[:current_user]
    manages= Tasktrack.Assignments.manages_map_for(current_user.id)
    tasks = Assignments.list_tasks()  
    render(conn, "index.html", tasks: tasks, manages: manages)
  end

  def new(conn, _params) do
    current_user = conn.assigns[:current_user]
    manages= Tasktrack.Assignments.manages_map_for(current_user.id)
    |>IO.inspect
    tasks = Assignments.list_tasks()
    new_task = %Task{assigned_by_id: conn.assigns[:current_user].id}
    changeset = Assignments.change_task(new_task)
    render(conn, "new.html", changeset: changeset , manages: manages )
  end

  def create(conn, %{"task" => task_params}) do
    case Assignments.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: page_path(conn, :feed))
        {:error, %Ecto.Changeset{} = changeset} ->
          current_user = conn.assigns[:current_user]
          manages= Tasktrack.Assignments.manages_map_for(current_user.id)
          |>IO.inspect
          render(conn, "new.html", changeset: changeset, manages: manages )
        end
      end

      def show(conn, %{"id" => id}) do
        current_user = conn.assigns[:current_user]
        manages= Tasktrack.Assignments.manages_map_for(current_user.id)
        |>IO.inspect
        task = Assignments.get_task!(id)
        render(conn, "show.html", task: task , manages: manages)
      end

      def edit(conn, %{"id" => id}) do
        current_user = conn.assigns[:current_user]
        manages= Tasktrack.Assignments.manages_map_for(current_user.id)
        |>IO.inspect
        task = Assignments.get_task!(id)
        changeset = Assignments.change_task(task)
        render(conn, "edit.html", task: task, changeset: changeset, manages: manages)
      end

      def update(conn, %{"id" => id, "task" => task_params}) do
        task = Assignments.get_task!(id)
        case Assignments.update_task(task, task_params) do
          {:ok, task} ->
            conn
            |> put_flash(:info, "Task updated successfully.")
            |> redirect(to: page_path(conn, :feed))
            {:error, %Ecto.Changeset{} = changeset} ->
              current_user = conn.assigns[:current_user]
              manages= Tasktrack.Assignments.manages_map_for(current_user.id)
              |>IO.inspect
              render(conn, "edit.html", task: task, changeset: changeset, manages: manages)
            end
          end

          def completed(conn, %{"id" => id}) do
            task = Assignments.get_task!(id)
            new_task_params = %{
              "assigned_by_id" => task.assigned_by_id,
              "assigned_to_id" => task.assigned_to_id,
              "description" => task.description,
              "status" => "true",
              "time_taken" => task.time_taken,
              "title" => task.title
            }

            case Assignments.update_task(task, new_task_params) do
              {:ok, task} ->
                conn
                |> put_flash(:info, "Task marked as complete")
                |> redirect(to: page_path(conn, :feed))
                {:error, %Ecto.Changeset{} = changeset} ->
                  render(conn, "edit.html", task: task, changeset: changeset)
                end
              end

              def delete(conn, %{"id" => id}) do
                task = Assignments.get_task!(id)
                {:ok, _task} = Assignments.delete_task(task)

                conn
                |> put_flash(:info, "Task deleted successfully.")
                |> redirect(to: page_path(conn, :feed))
              end
            end
