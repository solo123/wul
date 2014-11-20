class CreateSecures < ActiveRecord::Migration
  def change
    create_table :secures do |t|
      t.string :pay_password

      t.timestamps
    end
  end
end
