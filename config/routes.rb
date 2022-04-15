Rails.application.routes.draw do
  root 'posts#index'

  devise_scope :user do
    # Redirests signing out users back to sign-in
    get 'users', to: 'devise/sessions#new'
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end

  resources :posts, only: %i[index new show create]

  devise_for :users
end
