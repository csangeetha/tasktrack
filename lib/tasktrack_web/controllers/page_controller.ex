defmodule TasktrackWeb.PageController do
  use TasktrackWeb, :controller
  alias Tasktrack.Assignments
  alias Tasktrack.Assignments.Task
  def index(conn, _params) do
    render conn, "index.html"
  end
  def feed(conn, _params) do
    tasks = Enum.reverse(Assignments.list_tasks())
    new_task = %Task{assigned_by_id: conn.assigns[:current_user].id}
    changeset = Assignments.change_task(new_task)
    current_user = conn.assigns[:current_user]
    manages= Tasktrack.Assignments.manages_map_for(current_user.id)
    assign(conn, :manages, manages)
    render conn, "feed.html", tasks: tasks, changeset: changeset, manages: manages
  end

  def report(conn, _params) do
    tasks = Enum.reverse(Tasktrack.Assignments.feed_tasks_for(conn.assigns[:current_user]))
    new_task = %Task{assigned_by_id: conn.assigns[:current_user].id}
    changeset = Assignments.change_task(new_task)
    current_user = conn.assigns[:current_user]
    manages= Tasktrack.Assignments.manages_map_for(current_user.id)
    assign(conn, :manages, manages)
    render conn, "report.html", tasks: tasks, changeset: changeset, manages: manages
  end
end
