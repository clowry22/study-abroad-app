class UserAuthenticationController < ApplicationController
  before_action(:force_user_sign_in)
  skip_before_action( :force_user_sign_in, { :only => [ :new_signup_form, :create_user, :signin_form, 
  :create_cookie, :delete_cookies, :authenticate]})
  #users
  def authenticate
    un = params.fetch("input_username")
    pw = params.fetch("input_password")

    user = User.where({ :username => un}).at(0)
    
    if user == nil     
      redirect_to("/user_sign_in", {:alert => "User not recognized"})
    else
    
      if user.authenticate(pw)
        session.store(:user_name, user.username)
        current_country = session[:most_recent_country] 
        if current_country == nil 
          redirect_to("/")
        else
          next_url = "/home/" + current_country.to_s
          redirect_to(next_url)
        end
      else
        redirect_to("/user_sign_in", {:alert => "Nice try, stranger!"})
      end

    end

  end

  def new_signup_form
    render({ :template => "home_templates/signupform.html.erb"})
  end

  def create_cookie
    user = User.where({ :username => params.fetch("input_username") }).first
    
    the_supplied_password = params.fetch("input_password")
    
    if user != nil
      are_they_legit = user.authenticate(the_supplied_password)
    
      if are_they_legit == false
        redirect_to("/sign_in", { :alert => "Incorrect password." })
      else
        session[:user_id] = user.id
      
        redirect_to("/", { :notice => "Signed in successfully." })
      end
    else
      redirect_to("/sign_in", { :alert => "No user with that email address." })
    end
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

    redirect_to("/user_sign_in", {:notice => "See you soon!"})
  end

  def signin_form
    render({ :template => "home_templates/signinform.html.erb"})
  end


end