Rails.application.routes.draw do

  resources :employee_notes
  resources :inline_attachments

  namespace :timeclock do
    resources :clock_records
    resources :clock_edits
    resources :clock_periods
    resources :reason_codes
  end
  
  resources :shift_notes do
    resources :comments, module: :shift_notes
  end

  scope module: 'thickness', path: 'thickness' do
    resources :blocks do
      resources :checks
    end
  end

  get '/thickness', to: 'thickness/blocks#index'

  scope module: 'print_queue', as: 'print_queue' do
    resources :print_jobs do 
      collection do
        get :send_print_cmd
      end
    end
  end

  scope module: 'print_queue', as: 'print_queue' do
    resources :print_job_rules
  end

  root 'print_queue/print_jobs#fail_index'

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
  
  get '/timeclock/login', to: 'timeclock#login'
  post '/timeclock/login', to: 'sessions#timeclock_create'
  get '/timeclock', to: 'timeclock#work'
  get '/timeclock/clock_periods(/:id)/user(/:user_id)', to: 'timeclock/clock_periods#user_summary', as: :user_summary, action: :get 

  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'

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
  
  namespace :dept_info do
    resources :folders
    resources :documents
  end
  
  get     '/dept_info',                             to: 'dept_info#index'
  get     '/dept_info/update',                      to: 'dept_info#update'

  get     '/maintenance/scheduled_task_status',     to: 'maintenance#scheduled_task_status'

  # QC Routes
  get '/qc/salt_spray', to: 'qc#salt_spray'

  scope module: 'qc', as: 'qc', path: 'qc' do
    resources :rejected_parts
    get '/rejected_parts(/:id)/pdf', to: 'rejected_parts#create_pdf'
  end

  
end
