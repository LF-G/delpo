
Rails.application.routes.draw do

  devise_for :usuarios, controllers: {registrations: 'usuarios/registrations'}
  resources :usuarios
  root 'pages#index'
  resources :obras
  resources :autores
  resources :editoras
  resources :cidades
  resources :moedor, only: [:new]
  post 'moedor/moer'
  get 'moedor/analise'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
