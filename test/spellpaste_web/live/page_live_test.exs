defmodule SpellpasteWeb.PageLiveTest do
  use SpellpasteWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Last"
    assert render(page_live) =~ "Last"
  end
end
