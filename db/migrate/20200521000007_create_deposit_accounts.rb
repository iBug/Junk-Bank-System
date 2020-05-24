class CreateDepositAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :deposit_accounts, comment: '储蓄账户' do |t|
      t.references :account, index: true, foreign_key: {on_delete: :cascade}
      t.float :interest_rate, comment: '利率'
      t.string :currency, limit: 3, default: 'BTC', comment: '货币类型'
    end

    create_table :created_deposit_accounts, comment: '储蓄账户开设记录' do |t|
      t.string :client_id, limit: 18, index: true, foreign_key: {to_table: :clients, on_delete: :restrict}
      t.string :branch_id, limit: 64, index: true, foreign_key: {to_table: :branches, on_delete: :restrict}
      t.references :deposit_account, index: true, foreign_key: {on_delete: :cascade}
    end
    add_index :created_deposit_accounts, [:client_id, :branch_id], unique: true
  end
end
