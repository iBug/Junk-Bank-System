class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts, comment: '账户' do |t|
      t.references :branch, index: true, foreign_key: { on_delete: :restrict }, comment: '开户支行'
      t.references :accountable, null: false, polymorphic: true, comment: '类型账户ID'
      t.decimal :balance, precision: 12, scale: 2, default: 0.0, comment: '余额'
      t.date :open_date, default: 'CURRENT_TIMESTAMP', comment: '开户日期'

      t.timestamps
    end
  end
end
