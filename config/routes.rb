Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :homes, only: [:index]
  get 'welcome/index'
  devise_for :users
  resources :users, except: [:destroy] do
    resources :organizations
    resources :forms do
      resources :form_submissions
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/forms/add_new_field', to: 'forms#add_new_field', as: 'add_new_field'
  post '/forms/:id/radio_fields/add_radio_option', to: 'radio_fields#add_radio_option'
  
  # resources :forms do
  #   resources :form_submissions
  # end

end
