Rails.application.routes.draw do

  # QC
  scope module: 'qc', as: 'qc', path: 'qc' do
    resources :rejected_parts
    get '/rejected_parts(/:id)/pdf', to: 'rejected_parts#recreate_pdf'
  end
  get '/qc/salt_spray', to: 'qc#salt_spray'
    # Salt Spray Tests
  resources :salt_spray_tests do
    resources :comments, module: :salt_spray_tests
    resources :salt_spray_test_checks
  end
  post 'send_salt_spray_test', to: 'salt_spray_tests#send_test', as: :send_salt_spray_test
  get 'salt_spray_test(/:id)/finalized', to: 'salt_spray_tests#finalized', as: :salt_spray_finalized

  resources :comments

  # Printing
  scope module: 'printing', as: 'printing' do
    resources :print_queues
    resources :print_queue_rules
    resources :workstations
    resources :workstation_groups
    resources :print_jobs do
      collection do
        get :send_print_cmd
        get :set_queue
      end
    end
  end
  get 'printing/print_job(/:id)/send', to: 'printing/print_jobs#send_print_cmd'

  # Employee Notes
  resources :employee_notes
  resources :inline_attachments

  # Timeclock
  namespace :timeclock do
    resources :clock_records
    resources :clock_edits
    resources :clock_periods
    resources :reason_codes
  end
  get  '/timeclock',         to: 'timeclock#punch' 
  get  '/timeclock/login',   to: 'timeclock#login'
  get '/timeclock/on_clock', to: 'timeclock#on_clock'
  post '/timeclock/login',   to: 'sessions#timeclock_create'
  patch 'timeclock',         to: 'timeclock#update_pin', as: :update_pin
  
  # Shift Notes
  resources :shift_notes do
    resources :comments, module: :shift_notes
  end

  # Thickness
  scope module: 'thickness', path: 'thickness' do
    resources :blocks do
      resources :checks
    end
  end
  get '/thickness', to: 'thickness/blocks#index'

  # Specifications
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
  
  # Sessions 
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
  get     '/logout',  to: 'sessions#destroy'

  # Queries
  get '/queries/promise_list',       to: 'queries#promise_list'
  get '/queries/receipts',           to: 'queries#receipts'
  get '/queries/prop65(/:customer)', to: 'queries#prop65'

  post '/system_i/update_user', to: 'system_i#update_user'

  # Opto Logs
  post '/opto/log',  to: 'opto#log'
  get  '/opto/logs', to: 'opto#logs'

  get '/materials/vat_history_notes', to: 'materials#vat_history_notes'

  # Users
  namespace :admin do
    resources :users
    resources :permissions
  end

  # Dept Info
  namespace :dept_info do
    resources :folders
    resources :documents
  end  
  get '/dept_info',                         to: 'dept_info#index'
  get '/dept_info/update',                  to: 'dept_info#update'

  get '/maintenance/scheduled_task_status', to: 'maintenance#scheduled_task_status'
 
end
