defmodule Flightex.Users.User do
  @keys [:id, :name, :cpf, :email]
  @enforce_keys @keys
  defstruct @keys

  def build(name, cpf, email)
  when is_bitstring(name)
  and String.match?(name, ~r/^[[:alpha:][:blank:]]+$/u)
  and is_bitstring(cpf)
  and is_bitstring(email)
  do
    {:ok,
      %__MODULE__{
        id: UUID.uuid4(),
        name: name,
        cpf: cpf,
        email: email
      }
    }
  end

  def build(_name, _cpf, _email) do
    {:error, "User not created!"}
  end
end
