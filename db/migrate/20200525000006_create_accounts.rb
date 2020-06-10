class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts, comment: '账户' do |t|
      t.references :branch, index: true, foreign_key: { on_delete: :cascade }
      t.references :client, index: true, foreign_key: { on_delete: :restrict }
      t.string :type, null: false, comment: '账户类型'
      t.decimal :balance, precision: 12, scale: 2, comment: '余额'
      t.date :open_date, default: -> { 'CURRENT_TIMESTAMP' }, comment: '开户日期'
      t.datetime :last_access, default: -> { 'CURRENT_TIMESTAMP' }, comment: '最近访问'

      # Extra fields for deposit accounts
      t.float :interest_rate, comment: '利率'
      t.string :currency, limit: 3, default: 'BTC', comment: '货币类型'

      # Extra fields for check accounts
      t.decimal :withdraw_amount, precision: 12, scale: 2, comment: '透支额'

      t.timestamps
    end
  end
end
