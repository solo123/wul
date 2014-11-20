class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|
      t.string :persona
      t.string :personb
      t.string :personc
      t.string :persond
      t.string :persone
      t.integer :product_id
      t.timestamps
    end
  end
end
