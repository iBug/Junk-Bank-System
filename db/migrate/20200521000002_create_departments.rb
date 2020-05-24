class CreateDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments, comment: '部门' do |t|
      t.string :name, limit: 64, comment: '名称'
      t.string :type, limit: 64, comment: '类型'

      t.timestamps
    end
  end
end
