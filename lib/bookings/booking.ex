defmodule Flightex.Bookings.Booking do
  @keys [:complete_date, :local_origin, :local_destination, :user_id, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(user_id, local_origin, local_destination, complete_date)
    when is_bitstring(user_id)
    and is_bitstring(local_origin)
    and is_bitstring(local_destination)
    and is_struct(complete_date, NaiveDateTime)
  do
        {:ok,
          %__MODULE__{
            id: UUID.uuid4(),
            user_id: user_id,
            local_origin: local_origin,
            local_destination: local_destination,
            complete_date: complete_date
          }
        }
  end

  def build(_user_id, _local_origin, _local_destination, _complete_date) do
    {:error, "Booking not created"}
  end
end
