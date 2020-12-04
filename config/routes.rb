Rails.application.routes.draw do
  #update country
  get("/update_country", { :controller => "country", :action => "update_country"})

  #my countries
  get("/my_countries", { :controller => "country", :action => "my_countries"})
  
  #home page, you indicate which country you're going to and the computer figures out the currency for you. Makes it easier for the user. 
  get("/", { :controller => "country", :action => "home"})
  #get("/home", { :controller => "country", :action => "index"})
  #signed-in home page with country pre-loaded
  #get("/:country", { :controller => "application", :action => "index"})
  get("/home/:country", { :controller => "country", :action => "index"})
  get("/home/:country/info", { :controller => "country", :action => "get_country_details"})

  #let's start with the currency exchange tab first
  get("/:country/currency_exchange", { :controller => "currency", :action => "index"})
  get("/:country/currency_exchange/:foreign_currency", { :controller => "currency", :action => "index"})

  #translate tab
  get("/:country/translate", { :controller => "language", :action => "index"})
  get("/:country/add_phrase", { :controller => "language", :action => "add_phrase_form"})
    get("/:country/add_phrase_results", { :controller => "language", :action => "add_phrase_results"})

  #users info
  get("/user_sign_up", { :controller => "user_authentication", :action => "new_signup_form"})
  get("/new_user_record", {:controller => "user_authentication", :action => "create_user" })
  get("/log_out", { :controller => "user_authentication", :action => "delete_cookies"})

  get("/user_sign_in", { :controller => "user_authentication", :action => "signin_form"})
  post("/verify_credentials", { :controller => "user_authentication", :action => "authenticate"})


end
