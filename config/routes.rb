Rails.application.routes.draw do

  get '/' => 'etchings#index'
  get '/exhibit' => 'etchings#exhibit'
  get '/swatch' => 'etchings#swatch'

  resources :etchings

end
