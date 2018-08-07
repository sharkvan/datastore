defmodule WebUi.Formatters.Currency do
  def to_short_currency(%Decimal{} = value) when value > 0 do
    :io_lib.format("~.2.0f", [Decimal.to_float(value)])
  end

  def to_short_currency(0) do
    "--"
  end

  def to_short_currency(nil) do
    "--"
  end
end
