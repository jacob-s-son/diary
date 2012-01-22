Diary::Application.routes.draw do
  devise_for :users

  resources :users, :only => [:show]
  resources :notes
  root :to => "notes#index"
end
