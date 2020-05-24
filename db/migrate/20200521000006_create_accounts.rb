class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts, comment: '账户' do |t|
      t.string :type, null: false, comment: '账户类型'
      t.decimal :balance, precision: 12, scale: 2, comment: '余额'
      t.date :open_date, default: -> { 'CURRENT_TIMESTAMP' }, comment: '开户日期'

      t.timestamps
    end
  end
end
