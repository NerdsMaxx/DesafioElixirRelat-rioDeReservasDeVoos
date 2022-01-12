defmodule Flightex.Users.User do
  @keys [:id, :name, :cpf, :email]
  @enforce_keys @keys
  defstruct @keys

  # defp name?(name) do
  #   String.match?(name, ~r/^[[:alpha:][:blank:]]+$/u)
  # end

  def build(name, cpf, email)
  when is_bitstring(name)
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

  def build(_name, cpf, _email)
  when not is_bitstring(cpf)
  do
    {:error, "Cpf must be a String"}
  end

  def build(_name, _cpf, _email) do
    {:error, "User not created"}
  end
end
