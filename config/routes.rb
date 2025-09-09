Rails.application.routes.draw do
  resources :sales
  resources :items
  devise_for :users
  resources :businesses
  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:
  # get("/your_first_screen", { :controller => "pages", :action => "first" })

  root "businesses#index"
end
