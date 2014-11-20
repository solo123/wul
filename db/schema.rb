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

ActiveRecord::Schema.define(version: 20141114084145) do

  create_table "account_invest_principals", force: true do |t|
    t.integer  "account_sub_invest_id"
    t.datetime "refund_time"
    t.decimal  "refund_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_invest_profits", force: true do |t|
    t.integer  "account_sub_invest_id"
    t.datetime "refund_time"
    t.decimal  "refund_amount",         precision: 14, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_operations", force: true do |t|
    t.string   "op_action"
    t.string   "op_name"
    t.string   "operator"
    t.string   "user_id"
    t.boolean  "op_result",                                 default: false
    t.integer  "op_result_code",                            default: 0
    t.integer  "integer",                                   default: 0
    t.decimal  "op_amount",        precision: 12, scale: 2, default: 0.0
    t.integer  "op_asset_id"
    t.decimal  "op_result_value"
    t.integer  "user_info_id"
    t.integer  "uinfo_id"
    t.integer  "op_account_id"
    t.string   "op_resource_name"
    t.integer  "op_resource_id"
    t.string   "operation_id"
    t.decimal  "op_result_value2"
    t.decimal  "uinfo_id2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_product_principals", force: true do |t|
    t.integer  "account_product_id"
    t.datetime "refund_time"
    t.decimal  "refund_amount",      precision: 14, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_product_profits", force: true do |t|
    t.integer  "account_product_id"
    t.datetime "refund_time"
    t.decimal  "refund_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_profits", force: true do |t|
    t.integer  "account_sub_invest_id"
    t.datetime "refund_time"
    t.decimal  "refund_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounts", force: true do |t|
    t.integer  "user_id"
    t.decimal  "useable_balance", precision: 14, scale: 2, default: 0.0
    t.decimal  "balance",         precision: 14, scale: 2, default: 0.0
    t.decimal  "frozen_balance",  precision: 14, scale: 2, default: 0.0
    t.decimal  "total_estate",    precision: 14, scale: 2, default: 0.0
    t.integer  "user_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "agreements", force: true do |t|
    t.string   "persona"
    t.string   "personb"
    t.string   "personc"
    t.string   "persond"
    t.string   "persone"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "analyzers", force: true do |t|
    t.string   "product"
    t.integer  "owner_num"
    t.decimal  "invest_num",            precision: 14, scale: 2, default: 0.0
    t.integer  "user_info_id"
    t.decimal  "total_charge_amount",   precision: 14, scale: 2, default: 0.0
    t.decimal  "total_withdraw_amount", precision: 14, scale: 2, default: 0.0
    t.decimal  "cash_freeze_amount",    precision: 14, scale: 2, default: 0.0
    t.decimal  "fee",                   precision: 14, scale: 2, default: 0.0
    t.decimal  "coupon_profit",         precision: 14, scale: 2, default: 0.0
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

  add_index "cms_blocks", ["page_id", "identifier"], name: "index_cms_blocks_on_page_id_and_identifier"

  create_table "cms_categories", force: true do |t|
    t.integer "site_id",          null: false
    t.string  "label",            null: false
    t.string  "categorized_type", null: false
  end

  add_index "cms_categories", ["site_id", "categorized_type", "label"], name: "index_cms_categories_on_site_id_and_categorized_type_and_label", unique: true

  create_table "cms_categorizations", force: true do |t|
    t.integer "category_id",      null: false
    t.string  "categorized_type", null: false
    t.integer "categorized_id",   null: false
  end

  add_index "cms_categorizations", ["category_id", "categorized_type", "categorized_id"], name: "index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id", unique: true

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

  add_index "cms_files", ["site_id", "block_id"], name: "index_cms_files_on_site_id_and_block_id"
  add_index "cms_files", ["site_id", "file_file_name"], name: "index_cms_files_on_site_id_and_file_file_name"
  add_index "cms_files", ["site_id", "label"], name: "index_cms_files_on_site_id_and_label"
  add_index "cms_files", ["site_id", "position"], name: "index_cms_files_on_site_id_and_position"

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

  add_index "cms_layouts", ["parent_id", "position"], name: "index_cms_layouts_on_parent_id_and_position"
  add_index "cms_layouts", ["site_id", "identifier"], name: "index_cms_layouts_on_site_id_and_identifier", unique: true

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

  add_index "cms_pages", ["parent_id", "position"], name: "index_cms_pages_on_parent_id_and_position"
  add_index "cms_pages", ["site_id", "full_path"], name: "index_cms_pages_on_site_id_and_full_path"

  create_table "cms_revisions", force: true do |t|
    t.string   "record_type",                  null: false
    t.integer  "record_id",                    null: false
    t.text     "data",        limit: 16777215
    t.datetime "created_at"
  end

  add_index "cms_revisions", ["record_type", "record_id", "created_at"], name: "index_cms_revisions_on_rtype_and_rid_and_created_at"

  create_table "cms_sites", force: true do |t|
    t.string  "label",                       null: false
    t.string  "identifier",                  null: false
    t.string  "hostname",                    null: false
    t.string  "path"
    t.string  "locale",      default: "en",  null: false
    t.boolean "is_mirrored", default: false, null: false
  end

  add_index "cms_sites", ["hostname"], name: "index_cms_sites_on_hostname"
  add_index "cms_sites", ["is_mirrored"], name: "index_cms_sites_on_is_mirrored"

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

  add_index "cms_snippets", ["site_id", "identifier"], name: "index_cms_snippets_on_site_id_and_identifier", unique: true
  add_index "cms_snippets", ["site_id", "position"], name: "index_cms_snippets_on_site_id_and_position"

  create_table "coupons", force: true do |t|
    t.integer  "user_id"
    t.decimal  "amount"
    t.string   "title"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delagators", force: true do |t|
    t.integer  "user_info_id"
    t.integer  "each_invest_amount"
    t.integer  "min_invest_amount"
    t.integer  "max_invest_period"
    t.integer  "min_remain_balance"
    t.integer  "status",             default: 0
    t.datetime "last_open_time"
    t.datetime "last_invest_time"
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

  add_index "employees", ["email"], name: "index_employees_on_email", unique: true
  add_index "employees", ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  add_index "employees", ["unlock_token"], name: "index_employees_on_unlock_token", unique: true

  create_table "employees_roles", force: true do |t|
    t.integer "employee_id"
    t.integer "role_id"
  end

  create_table "guarantee_companies", force: true do |t|
    t.integer  "invest_id"
    t.integer  "company_id"
    t.string   "report"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invest_principals", force: true do |t|
    t.integer  "invest_id"
    t.datetime "refund_time"
    t.decimal  "refund_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invest_profits", force: true do |t|
    t.integer  "invest_id"
    t.datetime "refund_time"
    t.decimal  "refund_amount"
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
    t.decimal  "annual_rate",           precision: 5,  scale: 2, default: 0.0
    t.decimal  "amount",                precision: 12, scale: 2, default: 0.0
    t.integer  "repayment_period"
    t.string   "repayment_method"
    t.decimal  "each_repayment_amount", precision: 12, scale: 2
    t.decimal  "free_invest_amount",    precision: 12, scale: 2
    t.datetime "invest_end_date"
    t.string   "remark"
    t.integer  "status",                                         default: 0
    t.string   "invest_type",                                    default: "fixed"
    t.boolean  "onsale",                                         default: false
    t.decimal  "discount_rate",         precision: 12, scale: 1, default: 0.0
    t.integer  "asset_id"
    t.decimal  "resell_price"
    t.datetime "profit_date"
    t.datetime "principle_date"
    t.integer  "product_id"
    t.string   "stage",                                          default: "normal"
    t.decimal  "current_principal",     precision: 12, scale: 2, default: 0.0
    t.string   "owner_name",                                     default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invest_number"
  end

  add_index "invests", ["asset_id"], name: "index_invests_on_asset_id", unique: true

  create_table "messages", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "creator"
    t.integer  "approval_id"
    t.integer  "user_info_id"
    t.datetime "release_time"
    t.datetime "expiration_time"
    t.integer  "status",          default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "importance",      default: 0
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
    t.decimal  "product_value"
    t.integer  "product_id"
    t.integer  "user_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "product_principals", force: true do |t|
    t.integer  "product_id"
    t.datetime "refund_time"
    t.decimal  "refund_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_profits", force: true do |t|
    t.integer  "product_id"
    t.datetime "refund_time"
    t.decimal  "refund_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "deposit_number"
    t.decimal  "total_amount",          precision: 12, scale: 2
    t.decimal  "annual_rate",           precision: 5,  scale: 2
    t.integer  "repayment_period"
    t.string   "repayment_method",                               default: "profit"
    t.decimal  "each_repayment_amount", precision: 12, scale: 2
    t.string   "guarantee"
    t.decimal  "free_invest_amount",    precision: 10, scale: 2
    t.decimal  "fixed_invest_amount",   precision: 10, scale: 2, default: 0.0
    t.string   "detail"
    t.string   "income_method"
    t.date     "join_date"
    t.string   "join_condition"
    t.date     "expiring_date"
    t.string   "premature_redemption"
    t.integer  "fee",                                            default: 1
    t.integer  "owner_num",                                      default: 0
    t.decimal  "order_amount",          precision: 10, scale: 0, default: 0
    t.string   "product_type",                                   default: "fixed"
    t.string   "stage",                                          default: "未发布"
    t.string   "display",                                        default: "hide"
    t.datetime "profit_date"
    t.string   "address"
    t.string   "usage"
    t.text     "usage_detail"
    t.string   "credit_level"
    t.datetime "principal_date"
    t.integer  "status",                                         default: 0
    t.integer  "min_limit",                                      default: 1000
    t.integer  "max_limit",                                      default: 100000
    t.integer  "each_repayment_period",                          default: 30
    t.boolean  "locked",                                         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "role_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "secures", force: true do |t|
    t.string   "pay_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_captcha_data", force: true do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key"

  create_table "sub_analyzers", force: true do |t|
    t.integer  "analyzer_id"
    t.string   "product_type"
    t.decimal  "total_principal",        precision: 14, scale: 2, default: 0.0
    t.decimal  "total_profit",           precision: 14, scale: 2, default: 0.0
    t.decimal  "punishment_amount",      precision: 14, scale: 2, default: 0.0
    t.decimal  "resell_amount",          precision: 14, scale: 2, default: 0.0
    t.decimal  "buyin_amount",           precision: 14, scale: 2, default: 0.0
    t.decimal  "total_invest_amount",    precision: 14, scale: 2, default: 0.0
    t.decimal  "invest_freeze_amount",   precision: 14, scale: 2, default: 0.0
    t.decimal  "order_freeze_amount",    precision: 14, scale: 2, default: 0.0
    t.decimal  "resell_profit",          precision: 14, scale: 2, default: 0.0
    t.decimal  "buyin_profit",           precision: 14, scale: 2, default: 0.0
    t.decimal  "resell_discount_amount", precision: 14, scale: 2, default: 0.0
    t.decimal  "buyin_discount_amount",  precision: 14, scale: 2, default: 0.0
    t.decimal  "resell_fee",             precision: 14, scale: 2, default: 0.0
    t.decimal  "remain_pricipal",        precision: 14, scale: 2, default: 0.0
    t.decimal  "remain_profit",          precision: 14, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.string   "trans_type"
    t.decimal  "operation_amount", precision: 14, scale: 2, default: 0.0
    t.decimal  "account_before",   precision: 14, scale: 2, default: 0.0
    t.decimal  "account_after",    precision: 14, scale: 2, default: 0.0
    t.decimal  "frozen_before",    precision: 14, scale: 2, default: 0.0
    t.decimal  "frozen_after",     precision: 14, scale: 2, default: 0.0
    t.integer  "user_info_id"
    t.string   "deposit_number"
    t.string   "product_type"
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
    t.integer  "secury_score",        default: 0
    t.string   "payment_password"
    t.integer  "message_num",         default: 0
    t.integer  "notify_num",          default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "mobile",                 default: "", null: false
    t.string   "username"
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
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "verifications", force: true do |t|
    t.string   "phone"
    t.string   "email"
    t.datetime "phonetime"
    t.string   "personalid"
    t.string   "phonestatus",          default: "confirming"
    t.string   "emailstatus",          default: "confirming"
    t.string   "idstatus",             default: "confirming"
    t.integer  "securyscore",          default: 0
    t.integer  "user_info_id"
    t.string   "verify_code"
    t.boolean  "phone_confirm_status", default: false
    t.string   "realname"
    t.string   "email_code"
    t.string   "passwd"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "passwordstatus",       default: "confirming"
    t.integer  "safe_question_id",     default: 0
    t.string   "safe_question_answer", default: ""
    t.string   "verify_secret",        default: ""
    t.boolean  "email_change",         default: false
    t.boolean  "mobile_change",        default: false
    t.boolean  "question_change",      default: false
  end

end
