Rails.application.routes.draw do
  #home page, you indicate which country you're going to and the computer figures out the currency for you. Makes it easier for the user. 
  
  #let's start with the currency exchange tab first
  get("/currency_exchange", { :controller => "currency", :action => "index"})
  get("/currency_exchange/:foreign_currency", { :controller => "currency", :action => "index"})

  #translate tab
end
