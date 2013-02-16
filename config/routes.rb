Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  get "movies/:id/similar", :to => 'movies#similar', :as => 'movies/similar'
end
