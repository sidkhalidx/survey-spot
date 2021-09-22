Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'forms#new'
  post '/forms/:id/add_new_field', to: 'forms#add_new_field', as: 'add_new_field'
  post '/forms/:id/radio_fields/add_radio_option', to: 'radio_fields#add_radio_option'
  
  resources :forms do
    resources :text_fields, :text_areas, only: [:new, :create, :update]
    resources :radio_fields do
      resources :radio_button_options, only: [:new, :create, :update]
    end
  end
end
