defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Users.CreateOrUpdate, as: UserCoU

  def start() do
    BookingAgent.start_link(%{})
  end

  # def start() do
  #   BookingAgent.start_link()
  # end

  def call(map) do
    add(map)
  end

  def add(%{
        user_id: user_id,
        local_origin: local_origin,
        local_destination: local_destination,
        complete_date: complete_date
      })
  do
    with {:ok, booking} <- Booking.build(user_id, local_origin, local_destination, complete_date)
    do
      BookingAgent.save(booking)
    end
  end

  # Prefiro esta função, já que ele verifica se existe ou não o usuário
  # Se não existir, não vai construir booking
  #
  # def add(%{
  #   user_id: user_id,
  #   local_origin: local_origin,
  #   local_destination: local_destination,
  #   complete_date: complete_date
  #   })
  # do
  #   with {:ok, _user} <- UserCoU.get(user_id),
  #       {:ok, booking} <- Booking.build(user_id, local_origin, local_destination, complete_date)
  #   do
  #     BookingAgent.save(booking)
  #   end
  # end

  def add(%{}) do
    {:error, "Booking not added"}
  end

  # defp add_booking(booking), do: BookingAgent.save(booking)

  # defp add_booking({:error, _reason}), do: {:error, "Booking not added!"}

  def remove(id), do: BookingAgent.remove(id)

  def get(id), do: BookingAgent.get(id)

  def get_all, do: BookingAgent.get_all()
end
