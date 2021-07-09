defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.Users.Create
  alias Wabanex.User

  describe "users queries" do
    test "When an valid id is given, return the user", %{conn: conn} do
      params = %{email: "gabriel@hotmail.com", name: "Gabriel", password: "abc123"}
      expected_response = %{"data" =>
        %{"getUser" =>
           %{ "email" => "gabriel@hotmail.com",
             "name" => "Gabriel"
            }
          }
      }

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
       {
          getUser(id: "#{user_id}"){
           name,
           email
          }
        }
      """

      response =
       conn
       |> post("/api/graphql", %{query: query})
       |> json_response(:ok)

    assert expected_response == response
    end
  end

  describe "user mutations" do
    test "when all params are valid, create a user", %{conn: conn} do

      mutation = """
       mutation {
         createUser(input: {
           name: "Leonidas",
           email: "leo@hotmail.com",
           password: "007223"
         }) {
           id,
           name
         }
       }
      """

    response =
     conn
     |> post("/api/graphql", %{query: mutation})
     |> json_response(:ok)

    assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "Leonidas"}}} = response
    end
  end
end
