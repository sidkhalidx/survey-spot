Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :homes, only: [:index]
  get 'welcome/index'
  devise_for :users
  resources :users do
    collection do
      get 'managers'
      get 'admins'
      get 'manager/new', to: 'users#manager'
      get 'admin/new', to: 'users#admin'
    end
    member do
      get 'password/', to: 'users#password'
    end
    resources :organizations
  end
  resources :forms do
    member do
      get 'emails'
      post 'post_send_emails'
      post 'resend_email'
      get 'result'
      get 'field/:field_id/answers', to: 'forms#answers', as: 'answers_of_field'
    end
    resources :form_submissions do
      # collection do
      #   get 'answers', to: 'form_submissions#answers'
      # end
    end
  end
  # get 'forms/:id'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/forms/add_new_field', to: 'forms#add_new_field', as: 'add_new_field'
  post '/forms/:id/radio_fields/add_radio_option', to: 'radio_fields#add_radio_option'

end