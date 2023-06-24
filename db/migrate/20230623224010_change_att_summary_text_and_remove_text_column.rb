class ChangeAttSummaryTextAndRemoveTextColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :games, :summary, :text
    remove_column :games, :text
  end
end
