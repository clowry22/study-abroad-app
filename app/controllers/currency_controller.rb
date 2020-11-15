class CurrencyController < ApplicationController
  def index
    @country = params.fetch("country").capitalize
    @matching_countries = Country.where({ :name => @country})
    @the_country = @matching_countries.first

      cookies.store(:most_recent_country, @country)
      render({ :template => "currency_templates/index.html.erb"})

    
  end

  
end