class CurrencyController < ApplicationController
  def index
    @country = params.fetch("country")
    @the_country = Country.new
    @the_country.name = @country
    @the_country.save

    @url = "https://restcountries.eu/rest/v2/name/" + @the_country.name.downcase
    @raw_country_data = open(@url).read
    @parsed_country_data = JSON.parse(@raw_country_data)
    @array_of_symbols = @parsed_country_data.at(0).fetch("currencies")
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