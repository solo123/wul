class AddQuestionToVerification < ActiveRecord::Migration
  def change
    add_column :verifications, :safe_question_id, :integer, :default => 0
    add_column :verifications, :safe_question_answer, :string, :default => ""
  end
end
