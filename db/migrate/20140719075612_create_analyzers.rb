class CreateAnalyzers < ActiveRecord::Migration
  def change
    create_table :analyzers do |t|
      t.string :product
      t.integer :owner_num
      t.decimal :invest_num

      t.timestamps
    end
  end
end
