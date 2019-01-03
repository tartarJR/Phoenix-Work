defmodule Takso.Bid do
  use Ecto.Schema
  import Ecto.Changeset


  schema "bids" do
    field :bid_amount, :float
    field :bid_date, :date
    field :user_name, :string
    belongs_to :item, Takso.Item, foreign_key: :item_id

    timestamps()
  end

  @doc false
  def changeset(bid, attrs) do
    bid
    |> cast(attrs, [:bid_amount, :user_name, :bid_date])
    |> validate_required([:bid_amount, :user_name, :bid_date])
  end
end
