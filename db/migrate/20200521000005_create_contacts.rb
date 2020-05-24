class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts, id: false, primary_key: :client_id, comment: '联系人' do |t|
      t.string :name, limit: 64, comment: '姓名'
      t.string :phone, limit: 64, comment: '电话'
      t.string :email, limit: 64, comment: 'Email'
      t.string :relationship, limit: 64, comment: '与客户关系'
      t.string :client_id, index: true, foreign_key: {to_table: :clients, on_delete: :cascade}
    end
  end
end
