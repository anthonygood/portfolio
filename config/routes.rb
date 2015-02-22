Rails.application.routes.draw do

  get '/swatch' => 'etchings#swatch'
  post '/inquiry' => 'inquiries#create'

  scope controller: 'etchings', action: 'index' do
    get '/(:id)'    
    get '/view/:id'
    get '/buy(/:id)'
  end
end
