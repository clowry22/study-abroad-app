class LanguageController < ApplicationController
  def index 
    @country = params.fetch("country")
    
    if @country != nil  
      if Country.where({ :name => @country}).present?
        matching_countries = Country.where({ :name => @country})
        @the_country = matching_countries.at(0)
      else 
        @the_country = Country.new
        @the_country.name = @country.capitalize
        @the_country.name = @the_country.name.gsub(" ", "%20")
        @the_country.name = @the_country.name.gsub("Å", "A")
        url = "https://restcountries.eu/rest/v2/name/" + @the_country.name.downcase()
        @raw_data = open(url).read
        @parsed_data = JSON.parse(@raw_data)

        @the_country.name = @the_country.name.capitalize.gsub("%20", " ")
        @the_country.capital = @parsed_data.at(0).fetch("capital") 
        @the_country.languages = @parsed_data.at(0).fetch("languages")
        @the_country.region = @parsed_data.at(0).fetch("region")
        @the_country.subregion = @parsed_data.at(0).fetch("subregion")
        @the_country.country_code = @parsed_data.at(0).fetch("alpha2Code")
        @the_country.currencies = @parsed_data.at(0).fetch("currencies")
        @the_country.population = @parsed_data.at(0).fetch("population")
        @the_country.save 
      end 

      cookies.store(:most_recent_country, @country)
      render({ :template => "translate_templates/index.html.erb"})
    else
      redirect_to("/")
    end

  end

  def add_phrase_form
    @country = params.fetch("country")
    @the_country = Country.new
    @the_country.name = @country
    @the_phrase = params.fetch("phrase")
    url = "https://restcountries.eu/rest/v2/name/" + @the_country.name.downcase()
    @raw_data = open(url).read
    @parsed_data = JSON.parse(@raw_data)
    @array_of_languages = @parsed_data.at(0).fetch("languages")
    render({ :template => "translate_templates/add_phrase.html.erb"})
  end

  def add_phrase_results
    @the_country = params.fetch("country")
    @the_phrase = params.fetch("phrase")
    @language = params.fetch("lang")
    
    render({ :template => "translate_templates/add_phrase_results.html.erb"})
  end
end