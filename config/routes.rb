Rails.application.routes.draw do

  resources :inline_attachments
  resources :shift_notes
  resources :specifications do
    collection do
      get   'archived'
      get   'deleted'
    end
    member do
      post  'duplicate'
      post  'archive'
      post  'unarchive'
      post  'undelete'
    end
  end
 
  root    'vms#home'

  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'

  get     '/queries/promise_list',                  to: 'queries#promise_list'
  get     '/queries/receipts',                      to: 'queries#receipts'

  post    '/system_i/update_user',                  to: 'system_i#update_user'

  post    '/opto/log',                              to: 'opto#log'
  get     '/opto/logs',                             to: 'opto#logs'

  get     '/materials/vat_history_notes',           to: 'materials#vat_history_notes'

  namespace :admin do
    resources :users
    resources :permissions
  end
  
  namespace :dept_info do
    resources :folders
    resources :documents
  end
  
  get     '/dept_info',                             to: 'dept_info#index'
  get     '/dept_info/update',                      to: 'dept_info#update'

  get     '/maintenance/scheduled_task_status',     to: 'maintenance#scheduled_task_status'
  
end
