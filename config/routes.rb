Rails.application.routes.draw do

  # QC Routes
  get '/qc/salt_spray', to: 'qc#salt_spray'

  scope module: 'qc', as: 'qc', path: 'qc' do
    resources :rejected_parts
    get '/rejected_parts(/:id)/pdf', to: 'rejected_parts#recreate_pdf'
  end

  # Printing Routes
  scope module: 'printing', as: 'printing' do
    resources :print_queues
    resources :print_queue_rules
  end
  scope module: 'printing', as: 'printing' do
    resources :print_jobs do
      collection do
        get :send_print_cmd
        get :set_queue
      end
    end
  end

  resources :salt_spray_tests do
    resources :comments, module: :salt_spray_tests
    resources :salt_spray_test_checks
  end
  post 'send_salt_spray_test', to: 'salt_spray_tests#send_test', as: :send_salt_spray_test

  get 'printing/print_job(/:id)/send', to: 'printing/print_jobs#send_print_cmd'

  resources :employee_notes
  resources :inline_attachments

  namespace :timeclock do
    resources :clock_records
    resources :clock_edits
    resources :clock_periods
    resources :reason_codes
  end

  get  '/timeclock/login',  to: 'timeclock#login'
  post '/timeclock/login',  to: 'sessions#timeclock_create'

  get  '/timeclock',        to: 'timeclock#punch' 
  get '/timeclock/on_clock', to: 'timeclock#on_clock'
  
  resources :shift_notes do
    resources :comments, module: :shift_notes
  end

  scope module: 'thickness', path: 'thickness' do
    resources :blocks do
      resources :checks
    end
  end

  get '/thickness', to: 'thickness/blocks#index'

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
 
  root :to => 'vms#home'
  
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
  get     '/logout',  to: 'sessions#destroy'

  get     '/queries/promise_list',                  to: 'queries#promise_list'
  get     '/queries/receipts',                      to: 'queries#receipts'
  get     '/queries/prop65(/:customer)',            to: 'queries#prop65'

  post    '/system_i/update_user',                  to: 'system_i#update_user'

  post    '/opto/log',                              to: 'opto#log'
  get     '/opto/logs',                             to: 'opto#logs'

  get     '/materials/vat_history_notes',           to: 'materials#vat_history_notes'

  namespace :admin do
    resources :users
    resources :permissions
  end

  patch 'timeclock', to: 'timeclock#update_pin', as: :update_pin
  
  namespace :dept_info do
    resources :folders
    resources :documents
  end
  
  get     '/dept_info',                             to: 'dept_info#index'
  get     '/dept_info/update',                      to: 'dept_info#update'

  get     '/maintenance/scheduled_task_status',     to: 'maintenance#scheduled_task_status'
 
end
