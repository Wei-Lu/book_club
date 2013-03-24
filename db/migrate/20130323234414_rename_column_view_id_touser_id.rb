class RenameColumnViewIdTouserId < ActiveRecord::Migration
  def up
     rename_column :likes, :review_id, :user_id
  end

  def down
  end
end
