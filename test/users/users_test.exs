defmodule Flightex.Users.UserTest do
  use ExUnit.Case

  alias Flightex.Users.User

  import Flightex.Factory

  describe "build/4" do
    test "when all params are valid, returns the user" do
      {:ok, response} =
        User.build(
          "Jp",
          "12345678900",
          "jp@banana.com"
        )

      expected_response = build(:users, id: response.id)

      assert response == expected_response
    end

    test "when cpf is a integer" do
      response =
        User.build(
          "Jp",
          112_250_055,
          "jp@banana.com"
        )

      expected_response = {:error, "Cpf must be a String"}

      assert response == expected_response
    end
  end
end
