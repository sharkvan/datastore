defmodule StockCraz.Utilities.DatesTest do
  use ExUnit.Case

  alias StockCraz.Utilities.Dates

  describe "Convert date to a fiscal quarter" do
    test "something" do
      assert 4 == Dates.quarter("2015-10-23T23:50:07,123+02:30")      
    end
  end
end
