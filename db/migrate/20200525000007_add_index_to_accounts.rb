class AddIndexToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_index :accounts, %i[client_id branch_id accountable_type], unique: true
  end
end
