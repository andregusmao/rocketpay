defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller

  alias Rocketpay.User

  action_fallback RocketpayWeb.FallbackController

  def list(conn, params) do
    with {:ok, [%User{}] = users} <- Rocketpay.list_users(params) do
      conn
      |> put_status(:ok)
      |> render("list.json", users: users)
    end
  end

  def create(conn, params) do
    with {:ok, %User{} = user} <- Rocketpay.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
