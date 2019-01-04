defmodule TaksoWeb.BidController do
  use TaksoWeb, :controller
  import Ecto.Query

  alias Takso.Repo
  alias Takso.Item
  alias Takso.Bid

  def summary(conn, _params) do
    items = Repo.all(Item)
    |> Enum.map(fn(item) ->
      max_bid = Repo.all(from b in Bid, where: b.item_id == ^item.id, select: b)
      |> Enum.reduce(item.price, fn(bid, acc) -> if bid.bid_amount > acc do bid.bid_amount else acc end end)

      # max_bid = Repo.one(from b in Bid, where: b.item_id == ^item.id, select: max(b.bid_amount))

      %{
        id: item.id,
        description: item.description,
        price: max_bid,
        closing_date: item.closing_date
      }
    end)

    conn
    |> json(%{items: items})
  end

  def create(conn, %{"item_id" => item_id, "bid_amount" => bid_amount, "user_name" => user_name}) do
    {float_bid_amount, _} = Float.parse(bid_amount)
    item = Repo.get(Item, item_id)

    max_bid = Repo.all(from b in Bid, where: b.item_id == ^item_id, select: b)
              |> Enum.reduce(item.price, fn(bid, acc) -> if bid.bid_amount > acc do bid.bid_amount else acc end end)


    if max_bid >= float_bid_amount do
      conn
      |> put_status(200)
      |> json(%{msg: "Rejected"})
    else

      Bid.changeset(%Bid{}, %{bid_amount: float_bid_amount, bid_date: Date.utc_today(), user_name: user_name, item_id: item_id})
      |> Repo.insert!

      conn
      |> put_status(201)
      |> json(%{msg: "Accepted"})
    end
  end

  def bids(conn, %{"item_id" => item_id}) do
    bids = Repo.all(from b in Bid, where: b.item_id == ^item_id, select: b)
    |> Enum.map(fn(bidding) ->
      %{
        id: bidding.id,
        date: bidding.bid_date,
        amount: bidding.bid_amount,
        user: bidding.user_name
      }
    end)

    conn
    |> json(%{bids: bids})
  end

end
