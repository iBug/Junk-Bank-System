class CreateDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments, comment: '部门' do |t|
      t.string :name, limit: 64, comment: '部门名称'
      t.string :type, limit: 64, comment: '部门类型'

      t.timestamps
    end
  end
end
