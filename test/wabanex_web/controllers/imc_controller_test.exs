defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when all params are valid, returns imc info", %{conn: conn} do
      params = %{"filename" => "students.csv"}
      expected_response = %{"result" =>
       %{"Dani" => 23.437499999999996,
         "Diego" => 23.04002019946976,
         "Gabul" => 22.857142857142858,
         "Rafael" => 24.897060231734173,
         "Rodrigo" => 26.234567901234566
        }
      }

      response =
      conn
      |> get(Routes.imc_path(conn, :index, params))
      |> json_response(:ok)

    assert response == expected_response
    end

    test "when params are invalid, returns an error", %{conn: conn} do
      params = %{"filename" => "tudents.csv"}
      expected_response = %{"result" => "Error while opening the file"}

      response =
      conn
      |> get(Routes.imc_path(conn, :index, params))
      |> json_response(:bad_request)

    assert response == expected_response
    end
  end
end
