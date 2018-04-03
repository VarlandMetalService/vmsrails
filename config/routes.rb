Rails.application.routes.draw do
  
  root    'vms#home'

  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'

  get     '/queries/promise_list',      to: 'queries#promise_list'
  get     '/queries/receipts',          to: 'queries#receipts'

  post    '/system_i/update_user',      to: 'system_i#update_user'

  resources :users
  
end
