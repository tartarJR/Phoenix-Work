defmodule Takso.Item do
  use Ecto.Schema
  import Ecto.Changeset


  schema "items" do
    field :closing_date, :date
    field :description, :string
    field :price, :float
    has_many :bids, Takso.Bid

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:description, :price, :closing_date])
    |> validate_required([:description, :price, :closing_date])
  end
end
