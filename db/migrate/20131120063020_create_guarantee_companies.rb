class CreateGuaranteeCompanies < ActiveRecord::Migration
  def change
    create_table :guarantee_companies do |t|
      t.integer :invest_id
      t.integer :company_id
      t.string :report

      t.timestamps
    end
  end
end
