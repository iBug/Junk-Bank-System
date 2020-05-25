class CreateBranches < ActiveRecord::Migration[6.0]
  def change
    create_table :branches, comment: '支行' do |t|
      t.string :name, limit: 64, comment: '名称'
      t.string :city, limit: 64, comment: '城市'
      t.decimal :assets, precision: 12, scale: 2, comment: '资产'

      t.timestamps
    end
  end
end
