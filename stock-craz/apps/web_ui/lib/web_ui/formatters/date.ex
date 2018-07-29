defmodule WebUi.Formatters.Date do
  def to_short_date(%DateTime{} = datetime) do
    :io_lib.format("~4..0B/~2..0B/~2..0B", [datetime.year, datetime.month, datetime.day])
  end
end
