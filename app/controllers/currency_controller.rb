class CurrencyController < ApplicationController
  def index
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")
    @array_of_symbols = @symbols_hash.keys

    @usd = @array_of_symbols.at(-21)
    render({ :template => "currency_templates/index.html.erb"})

    # @from_symbol = params.fetch("from_currency")
    # @to_symbol = params.fetch("to_currency")

    # url = "https://api.exchangerate.host/convert?from=" + @from_symbol + "&to=" + @to_symbol
    # @exchange_data = open(url).read
    # @parsed_exchange_data = JSON.parse(@exchange_data)
    # @exchange_info = @parsed_exchange_data.fetch("info")
    # @exchange_rate= @exchange_info.fetch("rate")
  end

  
end