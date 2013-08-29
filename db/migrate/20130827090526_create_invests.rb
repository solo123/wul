class CreateInvests < ActiveRecord::Migration
  def change
    create_table :invests do |t|
      t.string :jkbh
      t.string :jybh
			t.string :dz
			t.string :jkyt
			t.string :jkyssm
			t.string :xydj
			t.decimal :nhll
			t.decimal :jkje
			t.integer :hkqx
			t.string :hkfs
			t.decimal :mqhkje
			t.decimal :ktje
			t.datetime :jssj
			t.string :bz

      t.timestamps
    end
  end
end
