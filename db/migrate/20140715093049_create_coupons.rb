class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.integer :user_id
      t.decimal :amount
      t.string :title
      t.string :desc

      t.timestamps
    end
  end
end
