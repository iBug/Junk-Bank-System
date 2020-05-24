class CreateStaffs < ActiveRecord::Migration[6.0]
  def change
    create_table :staffs, id: false, comment: '员工' do |t|
      t.string :id, limit: 18, unique: true, null: false, comment: '身份证号'
      t.string :name, limit: 64, comment: '姓名'
      t.string :phone, limit: 64, comment: '电话'
      t.string :address, limit: 256, comment: '地址'

      t.date :start_date, comment: '开始工作日期'
      t.belongs_to :department
      t.belongs_to :branch
      t.boolean :manager, default: false, comment: '经理'

      t.timestamps
    end
  end
end
