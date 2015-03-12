Rails.application.routes.draw do
  get 'subjects/show'

  namespace :admin do
  get 'assignments/new'
  end
  get 'assign/new'
  get 'assign/update'
  get 'assign/destroy'
  get 'assign/show'

  root             'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup'  =>  'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :subjects
  resources :users do
    resources :courses, only: [:index, :show]
  end

  resources :courses do
    resources :users, only: [:index]
  end

  namespace :admin do
    resources :users
    resources :courses do
      resources :assignments
    end

    resources :subjects
  end
  resources :courses
  resources :activitys
end
