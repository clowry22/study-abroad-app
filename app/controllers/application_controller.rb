class ApplicationController < ActionController::Base
  def index
    #@country = params.fetch("country").downcase()
    @country = params.fetch("country")
    @the_country = Country.new
    @the_country.name = @country

    render({ :template => "home_templates/index.html.erb"})
  end

 def home
    @url = "https://restcountries.eu/rest/v2/all"
    @raw_data = open(@url).read
    @parsed_data = JSON.parse(@raw_data)
    @array_of_countries = @parsed_data

    render({ :template => "home_templates/home.html.erb"})
  end

  def update_country
    @url = "https://restcountries.eu/rest/v2/all"
    @raw_data = open(@url).read
    @parsed_data = JSON.parse(@raw_data)
    @array_of_countries = @parsed_data
    render({ :template => "home_templates/update_country.html.erb"})
  end

  def my_countries
    render({ :template => "home_templates/my_countries.html.erb"})
  end
end
