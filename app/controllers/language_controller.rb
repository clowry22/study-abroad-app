class LanguageController < ApplicationController
  def index 
    @country = params.fetch("country")
    @the_country = Country.new
    @the_country.name = @country
    url = "https://restcountries.eu/rest/v2/name/" + @the_country.name.downcase()
    @raw_data = open(url).read
    @parsed_data = JSON.parse(@raw_data)
    @array_of_languages = @parsed_data.at(0).fetch("languages")
    @the_country.languages = @array_of_languages
    render({ :template => "translate_templates/index.html.erb"})
  end

  def add_phrase_form
    @country = params.fetch("country")
    @the_phrase = params.fetch("phrase")
    render({ :template => "translate_templates/add_phrase.html.erb"})
  end

  def add_phrase_results
    @country = params.fetch("country")
    @the_phrase = params.fetch("phrase")
    @language = params.fetch("lang")
    
    render({ :template => "translate_templates/add_phrase_results.html.erb"})
  end
end