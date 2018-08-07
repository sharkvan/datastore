defmodule WebUi.Formatters.Percentage do
  def to_short_percentage(%Decimal{} = percentage) when percentage > 0 do
    Decimal.to_float(percentage) * 100
  end

  def to_short_percentage(nil), do: "--"
end
