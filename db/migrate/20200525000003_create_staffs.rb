class CreateStaffs < ActiveRecord::Migration[6.0]
  def change
    create_table :staffs, comment: '员工' do |t|
      t.string :person_id, limit: 18, unique: true, null: false, comment: '身份证号'
      t.string :name, limit: 64, comment: '姓名'
      t.string :phone, limit: 64, comment: '电话'
      t.string :address, limit: 256, comment: '家庭地址'
      t.date :start_date, default: -> { 'CURRENT_TIMESTAMP' }, comment: '开始工作日期'
      t.boolean :manager, default: -> { false }, comment: '经理'

      t.references :branch, index: true, foreign_key: { on_delete: :restrict }
      t.references :department, index: true, foreign_key: { on_delete: :restrict }

      t.timestamps
    end
  end
end
