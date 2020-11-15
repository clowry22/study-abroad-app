class CurrencyController < ApplicationController
  def index
    @country = params.fetch("country")

    if @country != nil  
      if Country.where({ :name => @country}).present?
        matching_countries = Country.where({ :name => @country})
        @the_country = matching_countries.at(0)
      else 
        @the_country = Country.new
        @the_country.name = @country
        @the_country.save 
      end 

      @the_country.name = @the_country.name.gsub(" ", "%20")
      url = "https://restcountries.eu/rest/v2/name/" + @the_country.name.downcase()
      @raw_data = open(url).read
      @parsed_data = JSON.parse(@raw_data)

      @the_country.capital = @parsed_data.at(0).fetch("capital") 
      @the_country.languages = @parsed_data.at(0).fetch("languages")
      @the_country.region = @parsed_data.at(0).fetch("region")
      @the_country.subregion = @parsed_data.at(0).fetch("subregion")
      @the_country.country_code = @parsed_data.at(0).fetch("alpha2Code")
      @the_country.currencies = @parsed_data.at(0).fetch("currencies")
      @the_country.population = @parsed_data.at(0).fetch("population")

      cookies.store(:most_recent_country, @country)
      render({ :template => "currency_templates/index.html.erb"})
    else
      redirect_to("/")
    end
    
  end

  
end