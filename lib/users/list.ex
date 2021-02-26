defmodule Rocketpay.Users.List do
  alias Rocketpay.{Repo, User}

  def call(params) do
    Repo.all(User)
    |> IO.inspect()
  end
end
