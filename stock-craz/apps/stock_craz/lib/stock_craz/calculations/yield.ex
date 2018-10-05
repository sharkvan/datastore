defmodule StockCraz.Calculations.Yield do
  defstruct [
    :price,
    :amount
  ]

  alias StockCraz.Calculations.Yield

  @spec calc(any, any) :: float
  def calc(pr, amt) do
    calc(price(pr, amount(amt)))
  end

  @spec calc(%Yield{}) :: float
  def calc(%Yield{:price => 0}), do: 0
  def calc(%Yield{:price => 0.0}), do: 0
  def calc(%Yield{} = factors) do
    factors.amount / factors.price
  end

  @type yieldAssigner :: (number, %Yield{} -> %Yield{})

  @spec amount(any, %Yield{}, yieldAssigner) :: %Yield{}
  def amount(amount, yieldFactors \\ %Yield{}, assignment \\ fn value, factors -> %{ factors | :amount => value } end) do
    factor(amount, yieldFactors, assignment)
  end

  @spec amount(any, %Yield{}, yieldAssigner) :: %Yield{}
  def price(price, yieldFactors \\ %Yield{}, assignment \\ fn value, factors -> %{ factors | :price => value} end) do
    factor(price, yieldFactors, assignment)
  end

  @spec factor(any, %Yield{}, yieldAssigner) :: %Yield{}
  defp factor(value, yieldFactors, assignment) when is_binary(value) do
    factor(Float.parse(value), yieldFactors, assignment)
  end
  defp factor({0.0, _}, yieldFactors, assignment), do: factor(0, yieldFactors, assignment)
  defp factor({value, _}, yieldFactors, assignment), do: factor(value, yieldFactors, assignment)
  defp factor(:error, yieldFactors, assignment), do: factor(0, yieldFactors, assignment)
  defp factor(value, yieldFactors, assignment) when is_number(value) do
    assignment.(value, yieldFactors)
  end
end
