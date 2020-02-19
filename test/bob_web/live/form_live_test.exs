defmodule BobWeb.FormLiveTest do
  @moduledoc """
  `BobWeb.ConnCase` sets the following variables:

    * @endpoint
    * Routes

  Hints:

    * path to the LiveView: `Routes.live_path(@endpoint, FormLive)`
    * static test: `html = conn |> get(path) |> html_response(200)`
    * live test: `{:ok, view, _html} = live(conn, path)`
    * `render_*` sends events
    * `Floki.parse_document!(html) |> Floki.find(selector)`
  """

  use BobWeb.ConnCase
  import Phoenix.LiveViewTest

  alias BobWeb.FormLive

  describe "FormLive" do
    test "renders a form"

    test "renders an error when email is invalid"

    test "renders an error when email is not present"

    test "renders an error when email is in use"

    test "creates a user when form is valid"
  end
end
