defmodule Takso.Repo.Migrations.CreateBids do
  use Ecto.Migration

  def change do
    create table(:bids) do
      add :bid_amount, :float
      add :user_name, :string
      add :bid_date, :date

      timestamps()
    end

  end
end
