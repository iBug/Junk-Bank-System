class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues, comment: '逐次支付' do |t|
      t.references :loan, index: true, foreign_key: { on_delete: :cascade }
      t.date :date, default: 'CURRENT_TIMESTAMP', comment: '日期'
      t.decimal :amount, precision: 12, scale: 2, default: 0.0, comment: '金额'
    end
  end
end
