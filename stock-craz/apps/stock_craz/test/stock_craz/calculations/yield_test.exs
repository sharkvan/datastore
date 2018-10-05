defmodule StockCraz.Calculations.YieldTest do
  use ExUnit.Case

  alias StockCraz.Calculations.Yield
  describe "Zero amounts" do
    test "0" do
      assert 0 == Yield.calc(1, 0)
      assert 0 == Yield.calc("1", 0)
      assert 0 == Yield.calc("1", "0")
      assert 0 == Yield.calc(1, "0")
    end

    test "0.0" do
      assert 0 == Yield.calc(1, 0.0)
      assert 0 == Yield.calc("1", 0.0)
      assert 0 == Yield.calc(1, "0.0")
      assert 0 == Yield.calc("1", "0.0")
    end
  end

  describe "Zero prices" do
    test "0" do
      assert 0 == Yield.calc("0", 1)
      assert 0 == Yield.calc(0, 1)
      assert 0 == Yield.calc("0", "1")
      assert 0 == Yield.calc(0, "1")
    end

    test "0.0" do
      assert 0 == Yield.calc("0.0", 1)
      assert 0 == Yield.calc(0.0, 1)
      assert 0 == Yield.calc(0.0, "1")
      assert 0 == Yield.calc("0.0", "1")
    end
  end

  describe ".5" do
    test "1 / .5" do
      assert 0.5 == Yield.calc(1, 0.5)
      assert 0.5 == Yield.calc("1", "0.5")
      assert 0.5 == Yield.calc(1, "0.5")
      assert 0.5 == Yield.calc("1", 0.5)
    end

    test "2 / 1" do
      assert 0.5 == Yield.calc(2, 1)
      assert 0.5 == Yield.calc("2", "1")
      assert 0.5 == Yield.calc(2, "1")
      assert 0.5 == Yield.calc("2", 1)
    end
  end
end
