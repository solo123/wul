class AddAnalyzerData < ActiveRecord::Migration
  def up
      # Analyzer.create(product: "fixed", owner_num: 0, invest_num:0)
  end

  def down
    # Analyzer.delete_all
  end
end
