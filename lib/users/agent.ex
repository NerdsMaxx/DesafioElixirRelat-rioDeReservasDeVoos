defmodule Flightex.Users.Agent do
  alias Flightex.Users.User

  def start_link() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user) do
    Agent.update(__MODULE__, &Map.put(&1, user.id, user))
  end

  def remove(id), do: Agent.update(__MODULE__, &Map.delete(&1, id))

  def get(id), do: Agent.get(__MODULE__, &get_user(&1, id))

  def get_all, do: Agent.get(__MODULE__, & &1)

  defp get_user(map, id) do
    case Map.get(map, id) do
      user when is_struct(user, User) -> {:ok, user}
      _ -> {:error, "User not found!"}
    end
  end
end
