class AddImportanceToMessgae < ActiveRecord::Migration
  def change
    add_column :messages, :importance, :integer, :default => 0
  end
end
