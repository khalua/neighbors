Neighbors::Application.routes.draw do
  get '/search' => 'demographics#search'
  get '/query' => 'demographics#query'
  root :to => 'demographics#search'

end
