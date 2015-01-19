Rails.application.routes.draw do

  get '/' => 'etchings#index'
  get '/exhibit' => 'etchings#exhibit'

  resources :etchings

end
