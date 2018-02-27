defmodule TasktrackWeb.Time_BlockView do
  use TasktrackWeb, :view
  alias TasktrackWeb.Time_BlockView

  def render("index.json", %{time_blocks: time_blocks}) do
    %{data: render_many(time_blocks, Time_BlockView, "time__block.json")}
  end

  def render("show.json", %{time__block: time__block}) do
    %{data: render_one(time__block, Time_BlockView, "time__block.json")}
  end

  def render("time__block.json", %{time__block: time__block}) do
    %{id: time__block.id,
      start_time: time__block.start_time,
      end_time: time__block.end_time}
  end
end
