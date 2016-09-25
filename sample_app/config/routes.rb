Rails.application.routes.draw do
  get 'search/show'

  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'signup'  => 'users#new'
  get    'search'    => 'search#search'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get "searchUsers" => 'search#show'
  get "searchpost" => 'search#showPost'

  resources :users do
    member do
      get   'friends'     => 'users#friends'
      get   'requests'    => 'users#requests'
      get  'add_friend/:f_id'  => 'users#add_friend'
      get  'remove_friend/:f_id'  => 'users#remove_friend'
      get  'accept_request/:f_id'  => 'users#accept_request'
      get  'decline_request/:f_id'  => 'users#decline_request'
      get  'removepp' => 'users#removepp'
    end
  end
  resources :microposts,          only: [:create, :destroy]
end