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

ActiveRecord::Schema.define(version: 2020_05_25_000012) do

  create_table "accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "账户", force: :cascade do |t|
    t.bigint "branch_id", comment: "开户支行"
    t.string "accountable_type", null: false
    t.bigint "accountable_id", null: false, comment: "类型账户ID"
    t.decimal "balance", precision: 12, scale: 2, comment: "余额"
    t.date "open_date", comment: "开户日期"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accountable_type", "accountable_id"], name: "index_accounts_on_accountable_type_and_accountable_id"
    t.index ["branch_id"], name: "index_accounts_on_branch_id"
  end

  create_table "branches", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "支行", force: :cascade do |t|
    t.string "name", limit: 64, comment: "名称"
    t.string "city", limit: 64, comment: "城市"
    t.decimal "assets", precision: 12, scale: 2, comment: "资产"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "check_accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "支票账户", force: :cascade do |t|
    t.decimal "withdraw_amount", precision: 12, scale: 2, comment: "透支额"
  end

  create_table "clients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "客户", force: :cascade do |t|
    t.string "person_id", limit: 18, null: false, comment: "身份证号"
    t.string "name", limit: 64, comment: "姓名"
    t.string "phone", limit: 64, comment: "电话"
    t.string "address", limit: 256, comment: "地址"
    t.bigint "manager_id"
    t.integer "manager_type", limit: 1, default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["manager_id"], name: "index_clients_on_manager_id"
  end

  create_table "clients_loans", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "loans_id"
    t.bigint "client_id"
    t.index ["client_id"], name: "index_clients_loans_on_client_id"
    t.index ["loans_id"], name: "index_clients_loans_on_loans_id"
  end

  create_table "contacts", primary_key: "client_id", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "联系人", force: :cascade do |t|
    t.string "name", limit: 64, comment: "姓名"
    t.string "phone", limit: 64, comment: "电话"
    t.string "email", limit: 64, comment: "Email"
    t.string "relationship", limit: 64, comment: "与客户关系"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_contacts_on_client_id"
  end

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "部门", force: :cascade do |t|
    t.string "name", limit: 64, comment: "部门名称"
    t.string "kind", limit: 64, comment: "部门类型"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "deposit_accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "储蓄账户", force: :cascade do |t|
    t.float "interest_rate", comment: "利率"
    t.string "currency", limit: 3, default: "BTC", comment: "货币类型"
  end

  create_table "issues", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "逐次支付", force: :cascade do |t|
    t.bigint "loans_id"
    t.date "date", comment: "日期"
    t.decimal "amount", precision: 12, scale: 2, comment: "金额"
    t.index ["loans_id"], name: "index_issues_on_loans_id"
  end

  create_table "loans", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "贷款", force: :cascade do |t|
    t.decimal "amount", precision: 12, scale: 2, comment: "金额"
    t.bigint "branch_id"
    t.integer "status", limit: 1, comment: "状态"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["branch_id"], name: "index_loans_on_branch_id"
  end

  create_table "ownerships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "客户账户关系", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "client_id"
    t.bigint "branch_id"
    t.string "accountable_type"
    t.datetime "last_access", default: -> { "current_timestamp()" }, comment: "最近访问"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_ownerships_on_account_id"
    t.index ["branch_id"], name: "index_ownerships_on_branch_id"
    t.index ["client_id"], name: "index_ownerships_on_client_id"
  end

  create_table "staffs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "员工", force: :cascade do |t|
    t.string "person_id", limit: 18, null: false, comment: "身份证号"
    t.string "name", limit: 64, comment: "姓名"
    t.string "phone", limit: 64, comment: "电话"
    t.string "address", limit: 256, comment: "家庭地址"
    t.date "start_date", comment: "开始工作日期"
    t.boolean "manager", default: false, comment: "经理"
    t.bigint "branch_id"
    t.bigint "department_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["branch_id"], name: "index_staffs_on_branch_id"
    t.index ["department_id"], name: "index_staffs_on_department_id"
  end

  add_foreign_key "accounts", "branches", on_delete: :cascade
  add_foreign_key "clients", "staffs", column: "manager_id"
  add_foreign_key "clients_loans", "clients"
  add_foreign_key "clients_loans", "loans", column: "loans_id", on_delete: :cascade
  add_foreign_key "contacts", "clients", on_delete: :cascade
  add_foreign_key "issues", "loans", column: "loans_id", on_delete: :cascade
  add_foreign_key "loans", "branches"
  add_foreign_key "ownerships", "accounts", on_delete: :cascade
  add_foreign_key "ownerships", "branches"
  add_foreign_key "ownerships", "clients"
  add_foreign_key "staffs", "branches"
  add_foreign_key "staffs", "departments"
end
