class CreateClientAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :client_accounts, comment: '客户账户' do |t|
      t.references :client
      t.references :account
      t.datetime :last_access, null: true
    end
    add_index :client_accounts, [:client_id, :account_id], unique: true
  end
end
