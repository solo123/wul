class CreateEmployeesRoles < ActiveRecord::Migration
  def change
    create_table :employees_roles do |t|
   		t.belongs_to :employee
      t.belongs_to :role
    end
  end
end
