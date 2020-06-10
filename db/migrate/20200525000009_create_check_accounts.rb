class CreateCheckAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :check_accounts, comment: '支票账户' do |t|
      t.references :account, index: true, foreign_key: { on_delete: :cascade }
      t.decimal :withdraw_amount, precision: 12, scale: 2, comment: '透支额'
    end
  end
end
