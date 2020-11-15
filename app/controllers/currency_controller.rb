class CurrencyController < ApplicationController
  def index
    @country = params.fetch("country")
    @the_country = Country.new
    @the_country.name = @country
    @the_country.save
    @the_country.name = @the_country.name.gsub(" ", "%20")

    @url = "https://restcountries.eu/rest/v2/name/" + @the_country.name.downcase
    @raw_country_data = open(@url).read
    @parsed_country_data = JSON.parse(@raw_country_data)
    @array_of_symbols = @parsed_country_data.at(0).fetch("currencies")
    @the_country.name = @the_country.name.gsub("%20", " ")
    render({ :template => "currency_templates/index.html.erb"})
  end

  
end