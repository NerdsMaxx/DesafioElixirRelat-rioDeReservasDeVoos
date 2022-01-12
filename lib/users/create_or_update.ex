defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  def start() do
    UserAgent.start_link(%{})
  end

  # def start() do
  #   UserAgent.start_link()
  # end

  def call(params) do
    add(params)
  end

  def add(%{
        name: name,
        cpf: cpf,
        email: email
      }) do
    User.build(name, cpf, email)
    |> add_user()
  end

  def add(%{}) do
    {:error, "User not added"}
  end

  defp add_user({:ok, user}), do: UserAgent.save(user)

  defp add_user({:error, reason}), do: {:error, reason}

  def remove(id), do: UserAgent.remove(id)

  def get(id), do: UserAgent.get(id)

  def get_all, do: UserAgent.get_all()
end
