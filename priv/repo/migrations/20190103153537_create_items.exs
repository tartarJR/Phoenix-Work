defmodule Takso.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :description, :string
      add :price, :float
      add :closing_date, :date

      timestamps()
    end

  end
end
