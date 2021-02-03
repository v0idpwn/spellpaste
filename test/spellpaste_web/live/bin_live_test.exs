defmodule SpellpasteWeb.BinLiveTest do
  use SpellpasteWeb.ConnCase

  alias Spellpaste.Pastes

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, %{identifier: identifier}} = Pastes.create_bin("sample_text")

    {:ok, page_live, disconnected_html} = live(conn, "/b/#{identifier}")

    assert disconnected_html =~ "sample_text"
    assert render(page_live) =~ "sample_text"
  end

  test "increases view count", %{conn: conn} do
    {:ok, %{view_count: 0, identifier: identifier}} = Pastes.create_bin("sample_text")
    {:ok, page_live, disconnected_html} = live(conn, "/b/#{identifier}")

    assert render(page_live) =~ "View count: 1"
    assert disconnected_html =~ "View count: 1"

    {:ok, page_live, disconnected_html} = live(conn, "/b/#{identifier}")

    assert render(page_live) =~ "View count: 2"
    assert disconnected_html =~ "View count: 2"
  end
end
