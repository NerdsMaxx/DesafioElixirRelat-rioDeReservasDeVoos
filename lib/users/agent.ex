defmodule Flightex.Users.Agent do
  alias Flightex.Users.User

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
    :ok
  end

  # def start_link() do
  #   Agent.start_link(fn -> %{} end, name: __MODULE__)
  #   :ok
  # end

  def save(%User{id: id, cpf: cpf} = user) do
    Agent.update(__MODULE__, &Map.put(&1, cpf, user))
    {:ok, id}
  end

  # def save(%User{id: id} = user) do
  #   Agent.update(__MODULE__, &Map.put(&1, id, user))
  #   {:ok, id}
  # end

  def remove(cpf), do: Agent.update(__MODULE__, &Map.delete(&1, cpf))

  # def remove(id), do: Agent.update(__MODULE__, &Map.delete(&1, id))

  def get(cpf), do: Agent.get(__MODULE__, &get_user(&1, cpf))

  # def get(id), do: Agent.get(__MODULE__, &get_user(&1, id))

  def get_all, do: Agent.get(__MODULE__, & &1)

  defp get_user(map, cpf) do
    case Map.get(map, cpf) do
      user when is_struct(user, User) -> {:ok, user}
      _ -> {:error, "User not found"}
    end
  end

  # defp get_user(map, id) do
  #   case Map.get(map, id) do
  #     user when is_struct(user, User) -> {:ok, user}
  #     _ -> {:error, "User not found!"}
  #   end
  # end
end
