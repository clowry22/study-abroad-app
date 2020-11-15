class ApplicationController < ActionController::Base
  #users
  def authenticate
    un = params.fetch("input_username")
    pw = params.fetch("input_password")

    user = User.where({ :username => un}).at(0)
    
    if user == nil     
      redirect_to("/sign_in", {:alert => "No one by these name 'round these parts"})
    else
    
      if user.authenticate(pw)
        session.store(:user_name, user.username)
        redirect_to("/", {:notice => "Welcome back, " + user.username + "!"})
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
      redirect_to("/", {:notice => "Welcome, " + user.username + "!"})
    else  
      redirect_to("/sign_up", { :alert => user.errors.full_messages.to_sentence})
    end
  
  end

  def delete_cookies
    reset_session

    redirect_to("/", {:notice => "See ya later!"})
  end

  def signin_form
    render({ :template => "home_templates/signinform.html.erb"})
  end

  #home pages
  def index
    #@country = params.fetch("country").downcase()
    @country = params.fetch("country")
    @the_country = Country.new
    @the_country.name = @country
    cookies.store(:most_recent_country, @country)
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
    #@url = "https://restcountries.eu/rest/v2/all"
    #@raw_data = open(@url).read
    #@parsed_data = JSON.parse(@raw_data)
    #@array_of_countries = @parsed_data
    #render({ :template => "home_templates/update_country.html.erb"})
    the_country = params.fetch("country").downcase()
    redirect_to("/home/#{the_country}")
  end

  def my_countries
    render({ :template => "home_templates/my_countries.html.erb"})
  end
end
