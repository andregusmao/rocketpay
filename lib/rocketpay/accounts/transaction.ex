defmodule Rocketpay.Accounts.Transaction do
  alias Ecto.Multi
  alias Rocketpay.Accounts.Operation
  alias Rocketpay.Accounts.Transactions.Response, as: TransactionResponse
  alias Rocketpay.Repo

  def call(%{"from_account" => from_account, "to_account" => to_account, "value" => value}) do
    withdraw_params = build_params(from_account, value)
    deposit_params = build_params(to_account, value)

    Multi.new()
    |> Multi.merge(fn _changes -> Operation.call(withdraw_params, :withdraw) end)
    |> Multi.merge(fn _changes -> Operation.call(deposit_params, :deposit) end)
    |> run_transaction()
  end

  defp build_params(id, value), do: %{"id" => id, "value" => value}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} ->
        {:error, reason}

      {:ok, %{withdraw: from_account, deposit: to_account}} ->
        {:ok, TransactionResponse.build(from_account, to_account)}
    end
  end
end
