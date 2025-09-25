Rails.application.routes.draw do
  # NOTE: Awesome clean routes, might suggest closing off some routes for views that may not be used
  resources :sales
  resources :items, path: "inventory"
  devise_for :users
  resources :businesses
  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:
  # get("/your_first_screen", { :controller => "pages", :action => "first" })

  root "home#index"

  get "/rake_tasks", { :controller => "rake_tasks", :action => "show" }
  get "/run_task", { :controller => "rake_tasks", :action => "run_task" }
end
