defmodule NeatyWeb.PageController do
  use NeatyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
