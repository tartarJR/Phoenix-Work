# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Takso.Repo.insert!(%Takso.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Takso.{Repo, Accounts.User, Item}

[%{name: "Fred Flintstone", username: "fred", password: "parool"},
 %{name: "Barney Rubble", username: "barney", password: "parool"}]
|> Enum.map(fn user_data -> User.changeset(%User{}, user_data) end)
|> Enum.each(fn changeset -> Repo.insert!(changeset) end)

[
  %{description: "Air Jordan 11", price: 110.0, closing_date: "2019-01-11"},
  %{description: "Nike Air Force 1", price: 90.0, closing_date: "2019-01-13"},
  %{description: "Air Jordan Why Not 2.0", price: 120.0, closing_date: "2019-01-20"}
 ]
 |> Enum.each(fn item -> Repo.insert!(Item.changeset(%Item{}, %{description: item.description, price: item.price, closing_date: Date.from_iso8601!(item.closing_date) })) end)
