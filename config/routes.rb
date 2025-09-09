Rails.application.routes.draw do
  resources :items
  root businesses#index
  devise_for :users
  resources :businesses
  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:
  # get("/your_first_screen", { :controller => "pages", :action => "first" })
end
