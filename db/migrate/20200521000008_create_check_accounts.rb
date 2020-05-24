class CreateCheckAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :check_accounts, comment: '支票账户' do |t|
      t.references :account, index: true, foreign_key: {on_delete: :cascade}
      t.decimal :withdraw_amount, precision: 12, scale: 2, comment: '透支额'
    end

    create_table :created_check_accounts, comment: '支票账户开设记录' do |t|
      t.string :client_id, limit: 18, index: true, foreign_key: {to_table: :clients, on_delete: :restrict}
      t.string :branch_id, limit: 64, index: true, foreign_key: {to_table: :branches, on_delete: :restrict}
      t.references :check_account, index: true, foreign_key: {on_delete: :cascade}
    end
    add_index :created_check_accounts, [:client_id, :branch_id], unique: true
  end
end
