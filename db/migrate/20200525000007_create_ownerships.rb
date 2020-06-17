class CreateOwnerships < ActiveRecord::Migration[6.0]
  def change
    # (Client, Branch, AccountType) -> Account
    create_table :ownerships, comment: '客户账户关系' do |t|
      t.references :account, foreign_key: { on_delete: :cascade }
      t.references :client, foreign_key: { on_delete: :restrict }
      t.references :branch, foreign_key: { on_delete: :restrict }
      t.string :accountable_type
      t.datetime :last_access, default: -> { 'CURRENT_TIMESTAMP' }, comment: '最近访问'

      t.timestamps
    end
  end
end
