defmodule Flightex do
  alias Flightex.Bookings.CreateOrUpdate, as: BookingCoU
  alias Flightex.Users.CreateOrUpdate, as: UserCoU

  def start_agents() do
    UserCoU.start()
    BookingCoU.start()
  end

  defdelegate addUser(params), to: UserCoU, as: :add
  defdelegate addBooking(params), to: BookingCoU, as: :add

  defdelegate getUser(user_id), to: UserCoU, as: :get
  defdelegate getBooking(booking_id), to: BookingCoU, as: :get

  defdelegate getAllUsers(), to: UserCoU, as: :get_all
  defdelegate getAllBookings(), to: BookingCoU, as: :get_all

  defdelegate removeUser(user_id), to: UserCoU, as: :remove
  defdelegate removeBooking(booking_id), to: BookingCoU, as: :remove
end
