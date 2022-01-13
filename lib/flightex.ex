defmodule Flightex do
  alias Flightex.Bookings.CreateOrUpdate, as: BookingCoU
  alias Flightex.Bookings.Report, as: BookingReport
  alias Flightex.Users.CreateOrUpdate, as: UserCoU

  def start_agents() do
    UserCoU.start()
    BookingCoU.start()
  end

  #Este é para teste
  defdelegate create_or_update_booking(params), to: BookingCoU, as: :call

  defdelegate add_user(params), to: UserCoU, as: :add
  defdelegate add_booking(params), to: BookingCoU, as: :add

  defdelegate get_user(user_id), to: UserCoU, as: :get
  defdelegate get_booking(booking_id), to: BookingCoU, as: :get

  defdelegate get_all_users(), to: UserCoU, as: :get_all
  defdelegate get_all_bookings(), to: BookingCoU, as: :get_all

  defdelegate remove_user(user_id), to: UserCoU, as: :remove
  defdelegate remove_booking(booking_id), to: BookingCoU, as: :remove

  defdelegate generate_all_reports(filename), to: BookingReport, as: :generate_all_reports
  defdelegate generate_report(from_date, to_date), to: BookingReport, as: :generate_report
  defdelegate generate_report(from_date, to_date, filename), to: BookingReport, as: :generate_report
end
