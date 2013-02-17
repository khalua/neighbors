Neighbors::Application.routes.draw do
  get '/search' => 'demographics#search'
  get '/query' => 'demographics#query'
  post '/binders/add_to_binder' => 'binders#add_to_binder'
  resources :binders, :demographics, :people
  root :to => 'demographics#start'
end
