Rails.application.routes.draw do

  root    'vms#home'

  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'

  get     '/queries/promise_list',      to: 'queries#promise_list'
  get     '/queries/receipts',          to: 'queries#receipts'

  post    '/system_i/update_user',      to: 'system_i#update_user'

  namespace :admin do
    resources :users
  end
  
  namespace :dept_info do
    resources :folders
    resources :local_documents
    resources :google_documents
    resources :documents
  end
  get     '/dept_info',                 to: 'dept_info#index'
  
end
