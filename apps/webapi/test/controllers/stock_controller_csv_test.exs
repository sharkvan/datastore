defmodule Webapi.StockControllerCsvTest do
    use Webapi.ConnCase

    test "return csv without dividends", %{conn: conn} do
        post conn, "/", [stock: Map.drop(stock(), ["dividends"])]

        conn = get build_conn(), stock_controller_csv_path(conn, :csv)
        
        assert response(conn, 200) == "amount,change,eps,exDate,industry,payDate,price,sector,symbol,symbolName,yearHigh,yearLow\r\n,0.09,1.17,,Finance - Investment Funds,,5.79,\"SIC-6726 Unit Investment Trusts, Face-Amount\",TICC,TICC Capital Corp.,8.19,5.15\r\n" 
    end
    
    test "return csv", %{conn: conn} do
        post conn, "/", [stock: stock()]

        conn = get build_conn(), stock_controller_csv_path(conn, :csv)
        
        assert response(conn, 200) == "amount,change,eps,exDate,industry,payDate,price,sector,symbol,symbolName,yearHigh,yearLow\r\n0.2,0.09,1.17,2017-12-14,Finance - Investment Funds,2017-12-29,5.79,\"SIC-6726 Unit Investment Trusts, Face-Amount\",TICC,TICC Capital Corp.,8.19,5.15\r\n" 
    end

    def stock() do
        %{
         "yearLow" => "5.15",
         "yearHigh" => "8.19",
         "symbolName" => "TICC Capital Corp.",
         "symbol" => "TICC",
         "sector" => "SIC-6726 Unit Investment Trusts, Face-Amount",
         "price" => "5.79",
         "industry" => "Finance - Investment Funds",
         "eps" => "1.17",
         "dividends" => %{
                           "2016-03-31" => %{"payDate" => "2016-03-31","exDate" => "2016-03-15","amount" => "0.29"},
                           "2007-06-29" => %{"payDate" => "2007-06-29","exDate" => "2007-06-06","amount" => "0.36"},
                           "2010-12-31" => %{"payDate" => "2010-12-31","exDate" => "2010-12-08","amount" => "0.24"},
                           "2015-06-30" => %{"payDate" => "2015-06-30","exDate" => "2015-06-12","amount" => "0.29"},
                           "2006-12-29" => %{"payDate" => "2006-12-29","exDate" => "2006-12-06","amount" => "0.34"},
                           "2009-06-30" => %{"payDate" => "2009-06-30","exDate" => "2009-06-08","amount" => "0.15"},
                           "2008-09-30" => %{"payDate" => "2008-09-30","exDate" => "2008-09-08","amount" => "0.2"},
                           "2012-09-28" => %{"payDate" => "2012-09-28","exDate" => "2012-09-12","amount" => "0.29"},
                           "2004-12-31" => %{"payDate" => "2004-12-31","exDate" => "2004-12-29","amount" => "0.11"},
                           "2007-09-28" => %{"payDate" => "2007-09-28","exDate" => "2007-09-05","amount" => "0.36"},
                           "2008-06-30" => %{"payDate" => "2008-06-30","exDate" => "2008-06-12","amount" => "0.3"},
                           "2006-03-31" => %{"payDate" => "2006-03-31","exDate" => "2006-03-08","amount" => "0.3"},
                           "2007-12-31" => %{"payDate" => "2007-12-31","exDate" => "2007-12-06","amount" => "0.36"},
                           "2016-06-30" => %{"payDate" => "2016-06-30","exDate" => "2016-06-14","amount" => "0.29"},
                           "2009-09-30" => %{"payDate" => "2009-09-30","exDate" => "2009-09-08","amount" => "0.15"},
                           "2004-04-05" => %{"payDate" => "2004-04-05","exDate" => "2004-03-11","amount" => "0.1"},
                           "2014-09-30" => %{"payDate" => "2014-09-30","exDate" => "2014-09-12","amount" => "0.29"},
                           "2015-03-31" => %{"payDate" => "2015-03-31","exDate" => "2015-03-13","amount" => "0.27"},
                           "2016-09-30" => %{"payDate" => "2016-09-30","exDate" => "2016-09-14","amount" => "0.29"},
                           "2014-12-31" => %{"payDate" => "2014-12-31","exDate" => "2014-12-15","amount" => "0.29"},
                           "2005-09-30" => %{"payDate" => "2005-09-30","exDate" => "2005-09-07","amount" => "0.25"},
                           "2011-12-30" => %{"payDate" => "2011-12-30","exDate" => "2011-12-14","amount" => "0.25"},
                           "2004-09-30" => %{"payDate" => "2004-09-30","exDate" => "2004-09-08","amount" => "0.11"},
                           "2006-06-30" => %{"payDate" => "2006-06-30","exDate" => "2006-06-07","amount" => "0.3"},
                           "2017-03-31" => %{"payDate" => "2017-03-31","exDate" => "2017-03-14","amount" => "0.2"},
                           "2017-09-29" => %{"payDate" => "2017-09-29","exDate" => "2017-09-14","amount" => "0.2"},
                           "2004-06-30" => %{"payDate" => "2004-06-30","exDate" => "2004-06-08","amount" => "0.11"},
                           "2016-12-30" => %{"payDate" => "2016-12-30","exDate" => "2016-12-14","amount" => "0.29"},
                           "2006-09-29" => %{"payDate" => "2006-09-29","exDate" => "2006-09-06","amount" => "0.32"},
                           "2012-03-30" => %{"payDate" => "2012-03-30","exDate" => "2012-03-19","amount" => "0.27"},
                           "2015-12-31" => %{"payDate" => "2015-12-31","exDate" => "2015-12-14","amount" => "0.29"},
                           "2009-12-31" => %{"payDate" => "2009-12-31","exDate" => "2009-12-08","amount" => "0.15"},
                           "2013-09-30" => %{"payDate" => "2013-09-30","exDate" => "2013-09-12","amount" => "0.29"},
                           "2007-01-17" => %{"payDate" => "2007-01-17","exDate" => "2006-12-27","amount" => "0.12"},
                           "2011-03-31" => %{"payDate" => "2011-03-31","exDate" => "2011-03-17","amount" => "0.24"},
                           "2010-09-30" => %{"payDate" => "2010-09-30","exDate" => "2010-09-08","amount" => "0.22"},
                           "2013-06-28" => %{"payDate" => "2013-06-28","exDate" => "2013-06-12","amount" => "0.29"},
                           "2009-03-31" => %{"payDate" => "2009-03-31","exDate" => "2009-03-13","amount" => "0.15"},
                           "2008-12-31" => %{"payDate" => "2008-12-31","exDate" => "2008-12-08","amount" => "0.2"},
                           "2012-06-29" => %{"payDate" => "2012-06-29","exDate" => "2012-06-13","amount" => "0.27"},
                           "2013-12-31" => %{"payDate" => "2013-12-31","exDate" => "2013-12-13","amount" => "0.29"},
                           "2012-12-31" => %{"payDate" => "2012-12-31","exDate" => "2012-12-13","amount" => "0.29"},
                           "2006-01-18" => %{"payDate" => "2006-01-18","exDate" => "2005-12-28","amount" => "0.12"},
                           "2015-09-30" => %{"payDate" => "2015-09-30","exDate" => "2015-09-14","amount" => "0.29"},
                           "2010-03-31" => %{"payDate" => "2010-03-31","exDate" => "2010-03-22","amount" => "0.15"},
                           "2005-12-30" => %{"payDate" => "2005-12-30","exDate" => "2005-12-07","amount" => "0.3"},
                           "2014-03-31" => %{"payDate" => "2014-03-31","exDate" => "2014-03-21","amount" => "0.29"},
                           "2017-12-29" => %{"payDate" => "2017-12-29","exDate" => "2017-12-14","amount" => "0.2"},
                           "2005-06-30" => %{"payDate" => "2005-06-30","exDate" => "2005-06-08","amount" => "0.2"},
                           "2005-03-31" => %{"payDate" => "2005-03-31","exDate" => "2005-03-08","amount" => "0.14"},
                           "2014-06-30" => %{"payDate" => "2014-06-30","exDate" => "2014-06-12","amount" => "0.29"},
                           "2013-03-29" => %{"payDate" => "2013-03-29","exDate" => "2013-03-20","amount" => "0.29"},
                           "2008-03-31" => %{"payDate" => "2008-03-31","exDate" => "2008-03-18","amount" => "0.36"},
                           "2007-03-30" => %{"payDate" => "2007-03-30","exDate" => "2007-03-07","amount" => "0.36"},
                           "2017-06-30" => %{"payDate" => "2017-06-30","exDate" => "2017-06-14","amount" => "0.2"},
                           "2011-09-30" => %{"payDate" => "2011-09-30","exDate" => "2011-09-14","amount" => "0.25"},
                           "2010-06-30" => %{"payDate" => "2010-06-30","exDate" => "2010-06-08","amount" => "0.2"},
                           "2011-06-30" => %{"payDate" => "2011-06-30","exDate" => "2011-06-14","amount" => "0.25"},
                           },
         "change" => "0.09"
         }
    end
end
