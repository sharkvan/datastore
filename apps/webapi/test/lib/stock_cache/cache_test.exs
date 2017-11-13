defmodule Webapi.CacheTest do
    use ExUnit.Case

    test "cache and find stock price" do
        assert Webapi.StockCache.Cache.fetch(
            "IID", 
            fn -> %{"symbol" => "IID", "price" => 3.56} 
            end) == %{"symbol" => "IID", "price" => 3.56}
        
        assert Webapi.StockCache.Cache.fetch(
            "IID", fn -> "" end) == %{"symbol" => "IID", "price" => 3.56}

    end
end
