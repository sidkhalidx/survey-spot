Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'forms#new'
  post '/forms/add_new_field', to: 'forms#add_new_field', as: 'add_new_field'
  
  resources :forms do
    resources :text_fields, :text_areas, only: [:new, :create, :update]
  end

  resources :radio_fields, :radio_button_options, only: [:new, :create]

end
