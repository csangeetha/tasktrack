defmodule TasktrackWeb.Time_BlockController do
  use TasktrackWeb, :controller

  alias Tasktrack.Assignments
  alias Tasktrack.Assignments.Time_Block

  action_fallback TasktrackWeb.FallbackController

  def index(conn, _params) do
    time_blocks = Assignments.list_time_blocks()
    render(conn, "index.json", time_blocks: time_blocks)
  end

  def create(conn, %{"time__block" => time__block_params}) do
    with {:ok, %Time_Block{} = time__block} <- Assignments.create_time__block(time__block_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", time__block_path(conn, :show, time__block))
      |> render("show.json", time__block: time__block)
    end
  end

  def show(conn, %{"id" => id}) do
    time__block = Assignments.get_time__block!(id)
    render(conn, "show.json", time__block: time__block)
  end

  def update(conn, %{"id" => id, "time__block" => time__block_params}) do
    time__block = Assignments.get_time__block!(id)

    with {:ok, %Time_Block{} = time__block} <- Assignments.update_time__block(time__block, time__block_params) do
      render(conn, "show.json", time__block: time__block)
    end
  end

  def delete(conn, %{"id" => id}) do
    time__block = Assignments.get_time__block!(id)
    with {:ok, %Time_Block{}} <- Assignments.delete_time__block(time__block) do
      send_resp(conn, :no_content, "")
    end
  end
end
