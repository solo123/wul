# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140731072001) do

  create_table "accounts", force: true do |t|
    t.integer  "user_id"
    t.decimal  "useable_balance", precision: 10, scale: 0, default: 0
    t.decimal  "balance",         precision: 10, scale: 0, default: 0
    t.decimal  "frozen_balance",  precision: 10, scale: 0, default: 0
    t.decimal  "total_estate",    precision: 10, scale: 0, default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_info_id"
  end

  create_table "analyzers", force: true do |t|
    t.string   "product"
    t.integer  "owner_num"
    t.decimal  "invest_num", precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bankcards", force: true do |t|
    t.integer  "user_id"
    t.string   "bankname"
    t.string   "cardid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cms_blocks", force: true do |t|
    t.integer  "page_id",                     null: false
    t.string   "identifier",                  null: false
    t.text     "content",    limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_blocks", ["page_id", "identifier"], name: "index_cms_blocks_on_page_id_and_identifier", using: :btree

  create_table "cms_categories", force: true do |t|
    t.integer "site_id",          null: false
    t.string  "label",            null: false
    t.string  "categorized_type", null: false
  end

  add_index "cms_categories", ["site_id", "categorized_type", "label"], name: "index_cms_categories_on_site_id_and_categorized_type_and_label", unique: true, using: :btree

  create_table "cms_categorizations", force: true do |t|
    t.integer "category_id",      null: false
    t.string  "categorized_type", null: false
    t.integer "categorized_id",   null: false
  end

  add_index "cms_categorizations", ["category_id", "categorized_type", "categorized_id"], name: "index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id", unique: true, using: :btree

  create_table "cms_files", force: true do |t|
    t.integer  "site_id",                                    null: false
    t.integer  "block_id"
    t.string   "label",                                      null: false
    t.string   "file_file_name",                             null: false
    t.string   "file_content_type",                          null: false
    t.integer  "file_file_size",                             null: false
    t.string   "description",       limit: 2048
    t.integer  "position",                       default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_files", ["site_id", "block_id"], name: "index_cms_files_on_site_id_and_block_id", using: :btree
  add_index "cms_files", ["site_id", "file_file_name"], name: "index_cms_files_on_site_id_and_file_file_name", using: :btree
  add_index "cms_files", ["site_id", "label"], name: "index_cms_files_on_site_id_and_label", using: :btree
  add_index "cms_files", ["site_id", "position"], name: "index_cms_files_on_site_id_and_position", using: :btree

  create_table "cms_layouts", force: true do |t|
    t.integer  "site_id",                                     null: false
    t.integer  "parent_id"
    t.string   "app_layout"
    t.string   "label",                                       null: false
    t.string   "identifier",                                  null: false
    t.text     "content",    limit: 16777215
    t.text     "css",        limit: 16777215
    t.text     "js",         limit: 16777215
    t.integer  "position",                    default: 0,     null: false
    t.boolean  "is_shared",                   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_layouts", ["parent_id", "position"], name: "index_cms_layouts_on_parent_id_and_position", using: :btree
  add_index "cms_layouts", ["site_id", "identifier"], name: "index_cms_layouts_on_site_id_and_identifier", unique: true, using: :btree

  create_table "cms_pages", force: true do |t|
    t.integer  "site_id",                                         null: false
    t.integer  "layout_id"
    t.integer  "parent_id"
    t.integer  "target_page_id"
    t.string   "label",                                           null: false
    t.string   "slug"
    t.string   "full_path",                                       null: false
    t.text     "content",        limit: 16777215
    t.integer  "position",                        default: 0,     null: false
    t.integer  "children_count",                  default: 0,     null: false
    t.boolean  "is_published",                    default: true,  null: false
    t.boolean  "is_shared",                       default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_pages", ["parent_id", "position"], name: "index_cms_pages_on_parent_id_and_position", using: :btree
  add_index "cms_pages", ["site_id", "full_path"], name: "index_cms_pages_on_site_id_and_full_path", using: :btree

  create_table "cms_revisions", force: true do |t|
    t.string   "record_type",                  null: false
    t.integer  "record_id",                    null: false
    t.text     "data",        limit: 16777215
    t.datetime "created_at"
  end

  add_index "cms_revisions", ["record_type", "record_id", "created_at"], name: "index_cms_revisions_on_rtype_and_rid_and_created_at", using: :btree

  create_table "cms_sites", force: true do |t|
    t.string  "label",                       null: false
    t.string  "identifier",                  null: false
    t.string  "hostname",                    null: false
    t.string  "path"
    t.string  "locale",      default: "en",  null: false
    t.boolean "is_mirrored", default: false, null: false
  end

  add_index "cms_sites", ["hostname"], name: "index_cms_sites_on_hostname", using: :btree
  add_index "cms_sites", ["is_mirrored"], name: "index_cms_sites_on_is_mirrored", using: :btree

  create_table "cms_snippets", force: true do |t|
    t.integer  "site_id",                                     null: false
    t.string   "label",                                       null: false
    t.string   "identifier",                                  null: false
    t.text     "content",    limit: 16777215
    t.integer  "position",                    default: 0,     null: false
    t.boolean  "is_shared",                   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_snippets", ["site_id", "identifier"], name: "index_cms_snippets_on_site_id_and_identifier", unique: true, using: :btree
  add_index "cms_snippets", ["site_id", "position"], name: "index_cms_snippets_on_site_id_and_position", using: :btree

  create_table "coupons", force: true do |t|
    t.integer  "user_id"
    t.decimal  "amount",     precision: 10, scale: 0
    t.string   "title"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "show_name"
    t.string   "login_name"
    t.string   "phone"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employees", ["email"], name: "index_employees_on_email", unique: true, using: :btree
  add_index "employees", ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true, using: :btree
  add_index "employees", ["unlock_token"], name: "index_employees_on_unlock_token", unique: true, using: :btree

  create_table "employees_roles", force: true do |t|
    t.integer "employee_id"
    t.integer "role_id"
  end

  create_table "fixed_deposits", force: true do |t|
    t.string   "deposit_number"
    t.decimal  "total_amount",         precision: 12, scale: 2
    t.decimal  "annual_rate",          precision: 5,  scale: 2
    t.integer  "repayment_period"
    t.string   "guarantee"
    t.decimal  "free_invest_amount",   precision: 12, scale: 2
    t.string   "detail"
    t.string   "income_method"
    t.string   "join_date"
    t.string   "join_condition"
    t.date     "expiring_date"
    t.string   "repayment_method"
    t.string   "premature_redemption"
    t.string   "fee"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_num",                                     default: 0
    t.decimal  "order_amount",         precision: 10, scale: 0, default: 0
    t.string   "product_type",                                  default: "fixed"
    t.string   "status",                                        default: "未发布"
    t.string   "display",                                       default: "hide"
  end

  create_table "guarantee_companies", force: true do |t|
    t.integer  "invest_id"
    t.integer  "company_id"
    t.string   "report"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invests", force: true do |t|
    t.integer  "user_info_id"
    t.string   "loan_number"
    t.string   "transaction_number"
    t.string   "address"
    t.string   "usage"
    t.text     "usage_detail"
    t.string   "credit_level"
    t.decimal  "annual_rate",           precision: 5,  scale: 2
    t.decimal  "amount",                precision: 12, scale: 2
    t.integer  "repayment_period"
    t.string   "repayment_method"
    t.decimal  "each_repayment_amount", precision: 12, scale: 2
    t.decimal  "free_invest_amount",    precision: 12, scale: 2
    t.datetime "invest_end_date"
    t.string   "remark"
    t.integer  "status",                                         default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invest_type",                                    default: "fixed"
    t.boolean  "onsale",                                         default: false
    t.decimal  "discount_rate",         precision: 10, scale: 0, default: 0
  end

  create_table "month_deposits", force: true do |t|
    t.string   "deposit_number"
    t.string   "transaction_number"
    t.string   "address"
    t.string   "usage"
    t.text     "usage_detail"
    t.string   "credit_level"
    t.decimal  "annual_rate",           precision: 5,  scale: 2
    t.decimal  "amount",                precision: 12, scale: 2
    t.integer  "repayment_period"
    t.string   "repayment_method"
    t.decimal  "each_repayment_amount", precision: 12, scale: 2
    t.decimal  "free_invest_amount",    precision: 12, scale: 2
    t.datetime "invest_end_date"
    t.string   "remark"
    t.integer  "status",                                         default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_num",                                      default: 0
    t.string   "guarantee"
    t.datetime "join_date"
    t.datetime "expiring_date"
    t.string   "stage",                                          default: "未发布"
    t.string   "display",                                        default: "hide"
  end

  create_table "notices", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "creator_id"
    t.integer  "approval_id"
    t.datetime "release_time"
    t.datetime "expiration_time"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.string   "product_type"
    t.string   "product_name"
    t.decimal  "product_value", precision: 10, scale: 0
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "personal_assets", force: true do |t|
    t.integer  "user_info_id"
    t.string   "house_property"
    t.string   "housing_loan"
    t.string   "purchase_date"
    t.string   "car_property"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personal_credits", force: true do |t|
    t.integer  "user_info_id"
    t.string   "other_credit"
    t.string   "credit_cards"
    t.string   "credit_utilization_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personal_finances", force: true do |t|
    t.integer  "user_info_id"
    t.decimal  "monthly_income", precision: 12, scale: 2
    t.decimal  "dpi",            precision: 12, scale: 2
    t.decimal  "pcdi",           precision: 12, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personal_reviews", force: true do |t|
    t.integer  "user_info_id"
    t.date     "id_card_verify_date"
    t.date     "credit_report_date"
    t.date     "work_verify_date"
    t.date     "income_verify_date"
    t.integer  "guarantee_institution_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.string   "photo_data_type"
    t.integer  "photo_data_id"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "role_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stocks", force: true do |t|
    t.string   "deposit_number"
    t.string   "invest_type"
    t.decimal  "amount",         precision: 10, scale: 0
    t.integer  "user_id"
    t.decimal  "rate",           precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.string   "trans_type"
    t.decimal  "operation_amount", precision: 10, scale: 0
    t.decimal  "account_before",   precision: 10, scale: 0
    t.decimal  "account_after",    precision: 10, scale: 0
    t.decimal  "frozen_before",    precision: 10, scale: 0
    t.decimal  "frozen_after",     precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_companies", force: true do |t|
    t.integer  "user_info_id"
    t.decimal  "income",            precision: 12, scale: 2
    t.string   "age_of_business"
    t.string   "place_of_business"
    t.string   "business_status"
    t.string   "shareholding_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_infos", force: true do |t|
    t.integer  "user_id"
    t.string   "show_id"
    t.string   "gender"
    t.integer  "age"
    t.date     "birthday"
    t.string   "education"
    t.string   "education_from"
    t.string   "marital_status"
    t.integer  "childs_status"
    t.string   "domiciliary_reg"
    t.string   "real_name"
    t.string   "id_card_number"
    t.string   "mobile"
    t.datetime "id_card_verify_date"
    t.datetime "mobile_verify_date"
    t.integer  "status",              default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
