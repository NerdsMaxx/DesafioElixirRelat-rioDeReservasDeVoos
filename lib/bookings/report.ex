defmodule Flightex.Bookings.Report do
  def create(filename \\ "report_bookings.csv") do
    File.write!(filename, "")
    {:ok, "File created!"}
  end
end
