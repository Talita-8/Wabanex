defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "Douglas", email: "doug@gmail.com", password: "126698"}
      response = User.changeset(params)

      assert %Ecto.Changeset{
       valid?: true,
       changes: %{email: "doug@gmail.com", name: "Douglas", password: "126698"},
       errors: []
      } = response
    end

    test "when there are invalid params, returns a invalid changeset" do
      params = %{name: "D", email: "doug@gmail.com", password: "126698"}
      expected_response = %{name: ["should be at least 2 character(s)"]}
      response = User.changeset(params)

      assert errors_on(response) == expected_response
    end
  end
end
