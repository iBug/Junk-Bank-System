# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_21_000011) do

  create_table "accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "账户", force: :cascade do |t|
    t.string "type", null: false, comment: "账户类型"
    t.decimal "balance", precision: 12, scale: 2, comment: "余额"
    t.date "open_date", comment: "开户日期"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "branches", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "支行", force: :cascade do |t|
    t.string "name", limit: 64, comment: "名称"
    t.string "city", limit: 64, comment: "城市"
    t.decimal "assets", precision: 12, scale: 2, comment: "资产"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "check_accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "支票账户", force: :cascade do |t|
    t.bigint "account_id"
    t.decimal "withdraw_amount", precision: 12, scale: 2, comment: "透支额"
    t.index ["account_id"], name: "index_check_accounts_on_account_id"
  end

  create_table "client_accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "客户账户", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "account_id"
    t.datetime "last_access"
    t.index ["account_id"], name: "index_client_accounts_on_account_id"
    t.index ["client_id", "account_id"], name: "index_client_accounts_on_client_id_and_account_id", unique: true
    t.index ["client_id"], name: "index_client_accounts_on_client_id"
  end

  create_table "clients", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "客户", force: :cascade do |t|
    t.string "id", limit: 18, null: false, comment: "身份证号"
    t.string "name", limit: 64, comment: "姓名"
    t.string "phone", limit: 64, comment: "电话"
    t.string "address", limit: 256, comment: "地址"
    t.string "manager", limit: 18
    t.integer "manager_type", limit: 1, default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["manager"], name: "index_clients_on_manager"
  end

  create_table "clients_loans", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "loans_id"
    t.string "client_id", limit: 64
    t.index ["client_id"], name: "index_clients_loans_on_client_id"
    t.index ["loans_id"], name: "index_clients_loans_on_loans_id"
  end

  create_table "contacts", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "联系人", force: :cascade do |t|
    t.string "name", limit: 64, comment: "姓名"
    t.string "phone", limit: 64, comment: "电话"
    t.string "email", limit: 64, comment: "Email"
    t.string "relationship", limit: 64, comment: "与客户关系"
    t.string "client_id"
    t.index ["client_id"], name: "index_contacts_on_client_id"
  end

  create_table "created_check_accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "支票账户开设记录", force: :cascade do |t|
    t.string "client_id", limit: 18
    t.string "branch_id", limit: 64
    t.bigint "check_account_id"
    t.index ["branch_id"], name: "index_created_check_accounts_on_branch_id"
    t.index ["check_account_id"], name: "index_created_check_accounts_on_check_account_id"
    t.index ["client_id", "branch_id"], name: "index_created_check_accounts_on_client_id_and_branch_id", unique: true
    t.index ["client_id"], name: "index_created_check_accounts_on_client_id"
  end

  create_table "created_deposit_accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "储蓄账户开设记录", force: :cascade do |t|
    t.string "client_id", limit: 18
    t.string "branch_id", limit: 64
    t.bigint "deposit_account_id"
    t.index ["branch_id"], name: "index_created_deposit_accounts_on_branch_id"
    t.index ["client_id", "branch_id"], name: "index_created_deposit_accounts_on_client_id_and_branch_id", unique: true
    t.index ["client_id"], name: "index_created_deposit_accounts_on_client_id"
    t.index ["deposit_account_id"], name: "index_created_deposit_accounts_on_deposit_account_id"
  end

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "部门", force: :cascade do |t|
    t.string "name", limit: 64, comment: "名称"
    t.string "type", limit: 64, comment: "类型"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "deposit_accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "储蓄账户", force: :cascade do |t|
    t.bigint "account_id"
    t.float "interest_rate", comment: "利率"
    t.string "currency", limit: 3, default: "BTC", comment: "货币类型"
    t.index ["account_id"], name: "index_deposit_accounts_on_account_id"
  end

  create_table "issues", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "逐次支付", force: :cascade do |t|
    t.bigint "loans_id"
    t.date "date", comment: "日期"
    t.decimal "amount", precision: 12, scale: 2, comment: "金额"
    t.index ["loans_id"], name: "index_issues_on_loans_id"
  end

  create_table "loans", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "贷款", force: :cascade do |t|
    t.decimal "amount", precision: 12, scale: 2, comment: "金额"
    t.string "branch_id", limit: 64
    t.integer "status", limit: 1, comment: "状态"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["branch_id"], name: "index_loans_on_branch_id"
  end

  create_table "staffs", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "员工", force: :cascade do |t|
    t.string "id", limit: 18, null: false, comment: "身份证号"
    t.string "name", limit: 64, comment: "姓名"
    t.string "phone", limit: 64, comment: "电话"
    t.string "address", limit: 256, comment: "地址"
    t.date "start_date", comment: "开始工作日期"
    t.bigint "department_id"
    t.bigint "branch_id"
    t.boolean "manager", default: false, comment: "经理"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["branch_id"], name: "index_staffs_on_branch_id"
    t.index ["department_id"], name: "index_staffs_on_department_id"
  end

  add_foreign_key "check_accounts", "accounts", on_delete: :cascade
  add_foreign_key "clients_loans", "loans", column: "loans_id", on_delete: :cascade
  add_foreign_key "created_check_accounts", "check_accounts", on_delete: :cascade
  add_foreign_key "created_deposit_accounts", "deposit_accounts", on_delete: :cascade
  add_foreign_key "deposit_accounts", "accounts", on_delete: :cascade
  add_foreign_key "issues", "loans", column: "loans_id", on_delete: :cascade
end
