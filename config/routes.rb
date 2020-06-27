Rails.application.routes.draw do
  root 'stats#home'
  get '/about', to: 'stats#about', as: :about

  resources :branches
  resources :departments
  resources :staffs
  resources :clients
  resources :accounts
  resources :loans, except: %i[edit update]

  scope :branches do
    get ':id/staffs', to: 'branches#staffs', as: :branch_staffs
    get ':id/accounts', to: 'branches#accounts', as: :branch_accounts
    get ':id/loans', to: 'branches#loans', as: :branch_loans
  end

  scope :departments do
    get ':id/staffs', to: 'departments#staffs', as: :department_staffs
  end

  scope :staffs do
    get ':id/clients', to: 'staffs#clients', as: :staff_clients
  end

  scope :clients do
    get ':id/contact', to: 'clients#contact', as: :contact
    get ':id/accounts', to: 'clients#accounts', as: :client_accounts
    get ':id/loans', to: 'clients#loans', as: :client_loans
  end

  scope :accounts do
    get ':id/owners', to: 'accounts#owners', as: :account_owners
    post ':id/owners', to: 'ownerships#create', as: :new_account_owner
    delete ':id/owners/:client_id', to: 'ownerships#destroy', as: :destroy_account_owner
  end

  scope :loans do
    get ':id/issues', to: 'loans#issues', as: :loan_issues
    post ':id/issues', to: 'issues#create', as: :new_issue
    get ':id/clients', to: 'loans#clients', as: :loan_clients
  end

  resources :stats, only: %i[index] do
    collection do
      get 'deposit'
      get 'loan'
    end
  end
end
