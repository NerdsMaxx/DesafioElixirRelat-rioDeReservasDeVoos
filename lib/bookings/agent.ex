defmodule Flightex.Bookings.Agent do
  alias Flightex.Bookings.Booking

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
    :ok
  end

  # def start_link() do
  #   Agent.start_link(fn -> %{} end, name: __MODULE__)
  #   :ok
  # end

  def save(%Booking{id: id} = booking) do
    Agent.update(__MODULE__, &Map.put(&1, id, booking))
    {:ok, id}
  end

  def remove(id), do: Agent.update(__MODULE__, &Map.delete(&1, id))

  def get(id), do: Agent.get(__MODULE__, &get_booking(&1, id))

  def get_all, do: Agent.get(__MODULE__, & &1)

  defp get_booking(map, id) do
    case Map.get(map, id) do
      booking when is_struct(booking, Booking) -> {:ok, booking}
      _ -> {:error, "Booking not found"}
    end
  end
end
