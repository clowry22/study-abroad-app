class ApplicationController < ActionController::Base
  #users
  def authenticate
    un = params.fetch("input_username")
    pw = params.fetch("input_password")

    user = User.where({ :username => un}).at(0)
    
    if user == nil     
      redirect_to("/sign_in", {:alert => "User not recognized"})
    else
    
      if user.authenticate(pw)
        session.store(:user_name, user.username)
        current_country = cookies.fetch(:most_recent_country) #figure out how to make this variable unique to each user. session.store/session.fetch clears out most_recent_country whenever I log out
        next_url = "/home/" + current_country.to_s
        redirect_to(next_url)
      else
        redirect_to("/sign_in", {:alert => "Nice try, stranger!"})
      end

    end


  end

  def new_signup_form
    render({ :template => "home_templates/signupform.html.erb"})
  end

  def create_user
    user = User.new

    user.username = params.fetch("input_username")
    user.password = params.fetch("input_password")
    user.password_confirmation = params.fetch("input_password_confirmation")
    save_status = user.save

    if save_status == true
      session.store( :user_name, user.username)
      redirect_to("/", {:notice => "Hello, " + user.username + "!"})
    else  
      redirect_to("/sign_up", { :alert => user.errors.full_messages.to_sentence})
    end
  
  end

  def delete_cookies
    reset_session

    redirect_to("/", {:notice => "See you soon!"})
  end

  def signin_form
    render({ :template => "home_templates/signinform.html.erb"})
  end

  #home pages
  def index
    #@country = params.fetch("country").downcase()
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
      render({ :template => "home_templates/index.html.erb"})
    else
      redirect_to("/")
    end
  end

 def home
    @url = "https://restcountries.eu/rest/v2/all"
    @raw_data = open(@url).read
    @parsed_data = JSON.parse(@raw_data)
    @array_of_countries = @parsed_data

    render({ :template => "home_templates/home.html.erb"})
  end

  def update_country
    #@url = "https://restcountries.eu/rest/v2/all"
    #@raw_data = open(@url).read
    #@parsed_data = JSON.parse(@raw_data)
    #@array_of_countries = @parsed_data
    #render({ :template => "home_templates/update_country.html.erb"})
    the_country = params.fetch("country").downcase()
    session.store(:most_recent_country, @country)
    redirect_to("/home/#{the_country}")
  end

  def my_countries
    render({ :template => "home_templates/my_countries.html.erb"})
  end

  def get_country_details
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
      render({ :template => "home_templates/country_info.html.erb"})
    else
      redirect_to("/")
    end
    
  end
end
