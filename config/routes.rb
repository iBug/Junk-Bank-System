Rails.application.routes.draw do
  root to: 'stats#home'

  resources :branches
  resources :departments
  resources :staffs
  resources :clients
  resources :accounts
  resources :loans, except: %i[edit update]

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

  scope :stats do
    get '', to: 'stats#index', as: :stats
    get 'deposit', to: 'stats#deposit', as: :deposit_stats
    get 'loan', to: 'stats#loan', as: :loan_stats
  end
end
