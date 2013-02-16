Neighbors::Application.routes.draw do
  get '/search' => 'demographics#search'
  get '/query' => 'demographics#query'
  resources :binders
  resources :demographics
  root :to => 'demographics#search'
end
