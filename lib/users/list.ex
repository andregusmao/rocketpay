defmodule Rocketpay.Users.List do
  alias Rocketpay.{Repo, User}

  def call(_params) do
    users = Repo.all(User)
    {:ok, %{list_users: users}}
  end
end
