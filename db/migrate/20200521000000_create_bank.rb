class CreateBank < ActiveRecord::Migration[6.0]
  def change
    create_table :branches, id: false, primary_key: :name, comment: '支行' do |t|
      t.string :name, limit: 64, comment: '名称'
      t.string :city, limit: 64, comment: '城市'
      t.decimal :assets, precision: 12, scale: 2, comment: '资产'

      t.timestamps
    end

    create_table :departments, comment: '部门' do |t|
      t.string :name, limit: 64, '名称'
      t.string :type, limit: 64, '类型'

      t.timestamps
    end

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

    create_table :clients, id: false, comment: '客户' do |t|
      t.string :id, limit: 18, unique: true, null: false, comment: '身份证号'
      t.string :name, limit: 64, comment: '姓名'
      t.string :phone, limit: 64, comment: '电话'
      t.string :address, limit: 256, comment: '地址'

      t.references :manager, null: true, index: true, foreign_key: {to_table: :staffs, on_delete: :nullify}
      t.integer :manager_type, limit: 1, default: 0, null: true

      t.timestamps
    end

    create_table :contacts, primary_key: :client_id, comment: '联系人' do |t|
      t.string :name, limit: 64, comment: '姓名'
      t.string :phone, limit: 64, comment: '电话'
      t.string :email, limit: 64, comment: 'Email'
      t.string :relationship, limit: 64, comment: '与客户关系'
      t.references :client, index: true, foreign_key: {on_delete: :cascade}
    end

    create_table :accounts, comment: '账户' do |t|
      t.string :type, null: false, comment: '账户类型'
      t.decimal :balance, precision: 12, scale: 2, comment: '余额'
      t.date :open_date, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end

    create_table :deposit_accounts, comment: '储蓄账户' do |t|
      t.references :account, index: true, foreign_key: {on_delete: :cascade}
      t.float :interest_rate, comment: '利率'
      t.string :currency, limit: 3, default: 'BTC', comment: '货币类型'
    end

    create_table :check_accounts, comment: '支票账户' do |t|
      t.references :account, index: true, foreign_key: {on_delete: :cascade}
      t.decimal :withdraw_amount, precision: 12, scale: 2, comment: '透支额'
    end

    create_table :created_deposit_accounts, comment: '储蓄账户开设记录' do |t|
      t.references :client, index: true, foreign_key: {on_delete: :restrict_with_error}
      t.references :branch, index: true, foreign_key: {on_delete: :restrict_with_error}
      t.references :deposit_account, index: true, foreign_key: {on_delete: :cascade}
    end
    add_index :created_deposit_accounts, [:clients, :branches], unique: true

    create_table :created_check_accounts, comment: '支票账户开设记录' do |t|
      t.references :client, index: true, foreign_key: {on_delete: :restrict_with_error}
      t.references :branch, index: true, foreign_key: {on_delete: :restrict_with_error}
      t.references :check_account, index: true, foreign_key: {on_delete: :cascade}
    end
    add_index :created_check_accounts, [:clients, :branches], unique: true

    create_table :loans, comment: '贷款' do |t|
      t.decimal :amount, precision: 12, scale: 2, comment: '金额'
      t.references :branch, index: true, foreign_key: {on_delete: :restrict_with_error}
      t.integer :status, limit: 1, comment: '状态'

      t.timestamps
    end

    create_join_table :loans, :clients do |t|
      t.index :loan_id
      t.index :client_id
    end

    create_table :issues, comment: '逐次支付' do |t|
      t.references :loans, index: true, foreign_key: {on_delete: :cascade}
      t.date :date, comment: '日期'
      t.decimal :amount, precision: 12, scale: 2, comment: '金额'
    end

    create_table :client_accounts, comment: '客户账户' do |t|
      t.references :client
      t.references :account
      t.datetime :last_access, null: true
    end
    add_index :client_accounts, [:client_id, :account_id], unique: true
  end
end
