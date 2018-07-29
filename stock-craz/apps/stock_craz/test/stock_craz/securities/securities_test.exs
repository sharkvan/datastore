defmodule StockCraz.SecuritiesTest do
  use StockCraz.DataCase

  alias StockCraz.Securities

  describe "dividend_declarations" do
    alias StockCraz.Securities.DividendDeclaration

    @symbol "TICC"
    @valid_attrs %{amount: "120.5", dec_date: "2010-04-17 14:00:00.000000Z", ex_date: "2010-04-17 14:00:00.000000Z", pay_date: "2010-04-17 14:00:00.000000Z", rec_date: "2010-04-17 14:00:00.000000Z", stock_id: 42}
    @update_attrs %{amount: "456.7", dec_date: "2011-05-18 15:01:01.000000Z", ex_date: "2011-05-18 15:01:01.000000Z", pay_date: "2011-05-18 15:01:01.000000Z", rec_date: "2011-05-18 15:01:01.000000Z", stock_id: 43}
    @invalid_attrs %{amount: nil, dec_date: nil, ex_date: nil, pay_date: nil, rec_date: nil, stock_id: nil}

    def dividend_declaration_fixture(attrs \\ %{}) do
      {:ok, dividend_declaration} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Securities.create_dividend_declaration(@symbol)

      dividend_declaration
    end

    test "list_dividend_declarations/0 returns all dividend_declarations" do
      dividend_declaration = dividend_declaration_fixture()
      assert Securities.list_dividend_declarations(@symbol) == [dividend_declaration]
    end

    test "get_dividend_declaration!/1 returns the dividend_declaration with given id" do
      dividend_declaration = dividend_declaration_fixture()
      assert Securities.get_dividend_declaration!(dividend_declaration.id) == dividend_declaration
    end

    test "create_dividend_declaration/1 with valid data creates a dividend_declaration" do
      assert {:ok, %DividendDeclaration{} = dividend_declaration} = Securities.create_dividend_declaration(@valid_attrs, @symbol)
      assert dividend_declaration.symbol == @symbol
      assert dividend_declaration.amount == Decimal.new("120.5")
      assert dividend_declaration.dec_date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert dividend_declaration.ex_date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert dividend_declaration.pay_date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert dividend_declaration.rec_date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
    end

    test "create_dividend_declaration/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Securities.create_dividend_declaration(@invalid_attrs, @symbol)
    end

    test "update_dividend_declaration/2 with valid data updates the dividend_declaration" do
      dividend_declaration = dividend_declaration_fixture()
      assert {:ok, dividend_declaration} = Securities.update_dividend_declaration(dividend_declaration, @update_attrs, @symbol)
      assert %DividendDeclaration{} = dividend_declaration
      assert dividend_declaration.symbol == @symbol
      assert dividend_declaration.amount == Decimal.new("456.7")
      assert dividend_declaration.dec_date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert dividend_declaration.ex_date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert dividend_declaration.pay_date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert dividend_declaration.rec_date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
    end

    test "update_dividend_declaration/2 with invalid data returns error changeset" do
      dividend_declaration = dividend_declaration_fixture()
      assert {:error, %Ecto.Changeset{}} = Securities.update_dividend_declaration(dividend_declaration, @invalid_attrs, @symbol)
      assert dividend_declaration == Securities.get_dividend_declaration!(dividend_declaration.id)
    end

    test "delete_dividend_declaration/1 deletes the dividend_declaration" do
      dividend_declaration = dividend_declaration_fixture()
      assert {:ok, %DividendDeclaration{}} = Securities.delete_dividend_declaration(dividend_declaration)
      assert_raise Ecto.NoResultsError, fn -> Securities.get_dividend_declaration!(dividend_declaration.id) end
    end

    test "change_dividend_declaration/1 returns a dividend_declaration changeset" do
      dividend_declaration = dividend_declaration_fixture()
      assert %Ecto.Changeset{} = Securities.change_dividend_declaration(dividend_declaration)
    end
  end
end
