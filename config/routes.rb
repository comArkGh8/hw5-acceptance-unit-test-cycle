Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  
  # added similar movie route (find_movies_with_director in show.html.haml)
  get 'movies_with_director/:title' => 'movies#find', as: :find_movies_with_director
end
