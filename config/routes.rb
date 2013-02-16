Neighbors::Application.routes.draw do
  get '/search' => 'demographics#search'
  get '/query' => 'demographics#query'
  resources :binders, :demographics, :people
  root :to => 'demographics#start'
end
