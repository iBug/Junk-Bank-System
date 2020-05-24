class CreateLoans < ActiveRecord::Migration[6.0]
  def change
    create_table :loans, comment: '贷款' do |t|
      t.decimal :amount, precision: 12, scale: 2, comment: '金额'
      t.string :branch_id, limit: 64, index: true, foreign_key: {to_table: :branches, on_delete: :restrict}
      t.integer :status, limit: 1, comment: '状态'

      t.timestamps
    end

    create_table :clients_loans do |t|
      t.references :loans, index: true, foreign_key: {on_delete: :cascade}
      t.string :client_id, limit: 64, index: true, foreign_key: {to_table: :clients, on_delete: :restrict}
    end
  end
end
