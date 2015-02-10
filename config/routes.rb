Rails.application.routes.draw do

  get '/swatch' => 'etchings#swatch'

  scope controller: 'etchings', action: 'index' do
    get '/' 
    get '/:id' 
  end
end
