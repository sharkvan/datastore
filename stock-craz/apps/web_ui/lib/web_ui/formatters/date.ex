defmodule WebUi.Formatters.Date do
  def to_short_date(%DateTime{} = datetime) do
    :io_lib.format("~2..0B/~2..0B/~4..0B", [datetime.month, datetime.day, datetime.year])
  end
end
