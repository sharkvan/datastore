defmodule StockCraz.Utilities.DatesTest do
  use ExUnit.Case

  alias StockCraz.Utilities.Dates

  describe "Bad dates" do

    test "bad date" do
      assert 0 == Dates.quarter("2015-01-01")
      assert 0 == Dates.qtrMonth("2015-01-01")
    end
  end

  describe "Convert January to fiscal quarter" do

    setup do
      date = %DateTime{year: 2000, month: 1, day: 29, zone_abbr: "AMT",
        hour: 23, minute: 0, second: 7, microsecond: {0, 0},
        utc_offset: -14400, std_offset: 0, time_zone: "America/Manaus"}

      {:ok, date: date, date_string: DateTime.to_iso8601(date)}
    end

    test "when date is an ISO string", %{date_string: date} do
      assert 1 == Dates.quarter(date)      
      assert 1 == Dates.qtrMonth(date)
    end

    test "when date is datetime struct", %{date: date} do
      assert 1 == Dates.quarter(date)
      assert 1 == Dates.qtrMonth(date)
    end
  end

  describe "Convert February to a fiscal quarter" do
    setup do
      date = %DateTime{year: 2000, month: 2, day: 20, zone_abbr: "AMT",
        hour: 23, minute: 0, second: 7, microsecond: {0, 0},
        utc_offset: -14400, std_offset: 0, time_zone: "America/Manaus"}

      {:ok, date: date, date_string: DateTime.to_iso8601(date)}
    end

    test "when date is an ISO string", %{date_string: date} do
      assert 1 == Dates.quarter(date)      
      assert 2 == Dates.qtrMonth(date)
    end

    test "when date is datetime struct", %{date: date} do
      assert 1 == Dates.quarter(date)
      assert 2 == Dates.qtrMonth(date)
    end
  end

  describe "Convert March to a fiscal quarter" do
    setup do
      date = %DateTime{year: 2000, month: 3, day: 29, zone_abbr: "AMT",
        hour: 23, minute: 0, second: 7, microsecond: {0, 0},
        utc_offset: -14400, std_offset: 0, time_zone: "America/Manaus"}

      {:ok, date: date, date_string: DateTime.to_iso8601(date)}
    end
    
    test "when date is an ISO string" , %{date_string: date}do
      assert 1 == Dates.quarter(date)      
      assert 3 == Dates.qtrMonth(date)
    end

    test "when date is datetime struct", %{date: date} do
      assert 1 == Dates.quarter(date)
      assert 3 == Dates.qtrMonth(date)
    end
  end

  describe "Convert April to a fiscal quarter" do 
    setup do
      date = %DateTime{year: 2000, month: 4, day: 29, zone_abbr: "AMT",
        hour: 23, minute: 0, second: 7, microsecond: {0, 0},
        utc_offset: -14400, std_offset: 0, time_zone: "America/Manaus"}

      {:ok, date: date, date_string: DateTime.to_iso8601(date)}
    end
    
    test "when date is an ISO string" , %{date_string: date}do
      assert 2 == Dates.quarter(date)      
      assert 1 == Dates.qtrMonth(date)
    end

    test "when date is datetime struct", %{date: date} do
      assert 2 == Dates.quarter(date)
      assert 1 == Dates.qtrMonth(date)
    end
  end
  
  describe "Convert May to a fiscal quarter" do  
    setup do
      date = %DateTime{year: 2000, month: 5, day: 29, zone_abbr: "AMT",
        hour: 23, minute: 0, second: 7, microsecond: {0, 0},
        utc_offset: -14400, std_offset: 0, time_zone: "America/Manaus"}

      {:ok, date: date, date_string: DateTime.to_iso8601(date)}
    end
    
    test "when date is an ISO string" , %{date_string: date}do
      assert 2 == Dates.quarter(date)      
      assert 2 == Dates.qtrMonth(date)
    end

    test "when date is datetime struct", %{date: date} do
      assert 2 == Dates.quarter(date)
      assert 2 == Dates.qtrMonth(date)
    end
  end

  describe "Convert June to a fiscal quarter" do

    setup do
      date = %DateTime{year: 2000, month: 6, day: 29, zone_abbr: "AMT",
        hour: 23, minute: 0, second: 7, microsecond: {0, 0},
        utc_offset: -14400, std_offset: 0, time_zone: "America/Manaus"}

      {:ok, date: date, date_string: DateTime.to_iso8601(date)}
    end
    
    test "when date is an ISO string", %{date_string: date} do
      assert 2 == Dates.quarter(date)      
      assert 3 == Dates.qtrMonth(date)
    end

    test "when date is datetime struct", %{date: date} do
      assert 2 == Dates.quarter(date)
      assert 3 == Dates.qtrMonth(date)
    end
  end

  describe "Convert July to a fiscal quarter" do  
    setup do
      date = %DateTime{year: 2000, month: 7, day: 29, zone_abbr: "AMT",
        hour: 23, minute: 0, second: 7, microsecond: {0, 0},
        utc_offset: -14400, std_offset: 0, time_zone: "America/Manaus"}

      {:ok, date: date, date_string: DateTime.to_iso8601(date)}
    end
    
    test "when date is an ISO string", %{date_string: date} do
      assert 3 == Dates.quarter(date)      
      assert 1 == Dates.qtrMonth(date)
    end

    test "when date is datetime struct", %{date: date} do
      assert 3 == Dates.quarter(date)
      assert 1 == Dates.qtrMonth(date)
    end
  end

  describe "Convert August to a fiscal quarter" do
    setup do
      date = %DateTime{year: 2000, month: 8, day: 29, zone_abbr: "AMT",
        hour: 23, minute: 0, second: 7, microsecond: {0, 0},
        utc_offset: -14400, std_offset: 0, time_zone: "America/Manaus"}

      {:ok, date: date, date_string: DateTime.to_iso8601(date)}
    end
    
    test "when date is an ISO string", %{date_string: date} do
      assert 3 == Dates.quarter(date)      
      assert 2 == Dates.qtrMonth(date)
    end

    test "when date is datetime struct", %{date: date} do
      assert 3 == Dates.quarter(date)
      assert 2 == Dates.qtrMonth(date)
    end
  end

  describe "Convert September to a fiscal quarter" do
    setup do
      date = %DateTime{year: 2000, month: 9, day: 29, zone_abbr: "AMT",
        hour: 23, minute: 0, second: 7, microsecond: {0, 0},
        utc_offset: -14400, std_offset: 0, time_zone: "America/Manaus"}

      {:ok, date: date, date_string: DateTime.to_iso8601(date)}
    end
    
    test "when date is an ISO string", %{date_string: date} do
      assert 3 == Dates.quarter(date)      
      assert 3 == Dates.qtrMonth(date)
    end

    test "when date is datetime struct", %{date: date} do
      assert 3 == Dates.quarter(date)
      assert 3 == Dates.qtrMonth(date)
    end
  end

  describe "Convert October to a fiscal quarter" do
    setup do
      date = %DateTime{year: 2000, month: 10, day: 29, zone_abbr: "AMT",
        hour: 23, minute: 0, second: 7, microsecond: {0, 0},
        utc_offset: -14400, std_offset: 0, time_zone: "America/Manaus"}

      {:ok, date: date, date_string: DateTime.to_iso8601(date)}
    end
    
    test "when date is an ISO string", %{date_string: date} do
      assert 4 == Dates.quarter(date)      
      assert 1 == Dates.qtrMonth(date)
    end

    test "when date is datetime struct", %{date: date} do
      assert 4 == Dates.quarter(date)
      assert 1 == Dates.qtrMonth(date)
    end
  end

  describe "Convert November to a fical quarter" do
    setup do
      date = %DateTime{year: 2000, month: 11, day: 29, zone_abbr: "AMT",
        hour: 23, minute: 0, second: 7, microsecond: {0, 0},
        utc_offset: -14400, std_offset: 0, time_zone: "America/Manaus"}

      {:ok, date: date, date_string: DateTime.to_iso8601(date)}
    end
    
    test "when date is an ISO string", %{date_string: date} do
      assert 4 == Dates.quarter(date)      
      assert 2 == Dates.qtrMonth(date)
    end

    test "when date is datetime struct", %{date: date} do
      assert 4 == Dates.quarter(date)
      assert 2 == Dates.qtrMonth(date)
    end
  end

  describe "Convert December to a fiscal quarter" do
    setup do
      date = %DateTime{year: 2000, month: 12, day: 29, zone_abbr: "AMT",
        hour: 23, minute: 0, second: 7, microsecond: {0, 0},
        utc_offset: -14400, std_offset: 0, time_zone: "America/Manaus"}

      {:ok, date: date, date_string: DateTime.to_iso8601(date)}
    end
    
    test "when date is an ISO string", %{date_string: date} do
      assert 4 == Dates.quarter(date)      
      assert 3 == Dates.qtrMonth(date)
    end

    test "when date is datetime struct", %{date: date} do
      assert 4 == Dates.quarter(date)
      assert 3 == Dates.qtrMonth(date)
    end
  end
end
