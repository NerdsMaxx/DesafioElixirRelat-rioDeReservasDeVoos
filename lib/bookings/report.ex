defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.CreateOrUpdate, as: BookingCoU

  def generate_all_reports(filename \\ "report_bookings.csv") do
    create_file(filename)

    BookingCoU.get_all()
    |> Map.values()
    |> Enum.map(&booking_str(&1))
    |> Enum.each(&add_in_report(&1, filename))

    {:ok, "Report generated successfully"}
  end

  def generate_report(from_date, to_date, filename \\ "report_bookings_based_on_date.csv")
    when is_struct(from_date, Date)
    and is_struct(to_date, Date)
  do
    create_file(filename)

    BookingCoU.get_all()
    |> Map.values()
    |> Enum.filter(&filter_based_on_date(&1, from_date, to_date))
    |> Enum.map(&booking_str(&1))
    |> Enum.each(&add_in_report(&1, filename))

    {:ok, "Report generated successfully"}
  end

  defp create_file(filename) do
    File.write(filename, "")
  end

  defp filter_based_on_date(%Booking{complete_date: complete_date}, from_date, to_date) do
    complete_date
    |> NaiveDateTime.to_date()
    |> compare_date(from_date, to_date)
  end

  defp compare_date(date, from_date, to_date) do
    compare1 = Date.compare(date, from_date)
    compare2 = Date.compare(date, to_date)
    (compare1 == :gt or compare1 == :eq) and (compare2 == :lt or compare2 == :eq)
  end

  defp booking_str(%Booking{user_id: user_id,
                            local_origin: local_origin,
                            local_destination: local_destination,
                            complete_date: complete_date})
  do
    "#{user_id},#{local_origin},#{local_destination},#{complete_date}\n"
  end

  # defp booking_str(%Booking{id: id,
  #                           user_id: user_id,
  #                           local_origin: local_origin,
  #                           local_destination: local_destination,
  #                           complete_date: complete_date})
  # do
  #   "#{id}, #{user_id}, #{local_origin}, #{local_destination}, #{complete_date}\n"
  # end

  defp add_in_report(report, filename) do
    File.write!(filename, report, [:append])
  end
end
