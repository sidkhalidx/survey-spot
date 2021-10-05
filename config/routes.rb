Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :homes, only: [:index]
  get 'welcome/index'
  devise_for :users
  resources :users do
    member do
      get 'managers'
      get 'admins'
      get 'manager/new', to: 'users#manager'
      get 'admin/new', to: 'users#admin'
    end
    resources :organizations
    resources :forms
    #   resources :form_submissions
    # end
  end
  resources :forms do
    member do
      get 'emails'
      post 'post_send_emails'
      post 'resend_email'
    end
    resources :form_submissions#, shallow: true
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/forms/add_new_field', to: 'forms#add_new_field', as: 'add_new_field'
  post '/forms/:id/radio_fields/add_radio_option', to: 'radio_fields#add_radio_option'

end