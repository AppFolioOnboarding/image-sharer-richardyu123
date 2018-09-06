Rails.application.routes.draw do
  resources :image_emails, only: %i[create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :images, only: %i[new create show index destroy edit update]
  root 'images#new'
end
