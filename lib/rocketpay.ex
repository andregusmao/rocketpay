defmodule Rocketpay do
  alias Rocketpay.Users.Create, as: UserCreate
  alias Rocketpay.Users.List, as: UsersList

  alias Rocketpay.Accounts.{Deposit, Withdraw, Transaction}

  defdelegate list_users(params), to: UsersList, as: :call
  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate deposit(params), to: Deposit, as: :call
  defdelegate withdraw(params), to: Withdraw, as: :call
  defdelegate transaction(params), to: Transaction, as: :call
end
