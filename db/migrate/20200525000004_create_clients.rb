class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients, comment: '客户' do |t|
      t.string :person_id, limit: 18, unique: true, null: false, comment: '身份证号'
      t.string :name, limit: 64, comment: '姓名'
      t.string :phone, limit: 64, comment: '电话'
      t.string :address, limit: 256, comment: '地址'

      t.references :manager, null: true, index: true, foreign_key: {to_table: :staffs, on_delete: :nullify}
      t.integer :manager_type, limit: 1, default: 0, null: true

      t.timestamps
    end
  end
end
