class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|
      t.string :persona

      t.timestamps
    end
  end
end
