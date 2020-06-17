class AddIndexToOwnerships < ActiveRecord::Migration[6.0]
  def change
    add_index :ownerships, %i[branch_id accountable_type client_id], unique: true
  end
end
