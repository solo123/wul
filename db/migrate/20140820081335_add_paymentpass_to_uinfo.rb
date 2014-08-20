class AddPaymentpassToUinfo < ActiveRecord::Migration
  def change
    add_column :user_infos, :payment_password, :string
  end
end
