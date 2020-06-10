class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts, id: false, comment: '联系人' do |t|
      t.string :name, limit: 64, comment: '姓名'
      t.string :phone, limit: 64, comment: '电话'
      t.string :email, limit: 64, comment: 'Email'
      t.string :relationship, limit: 64, comment: '与客户关系'
      t.references :client, primary_key: true, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
