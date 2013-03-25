class RemoveTitleFromReviews < ActiveRecord::Migration
  def up
    remove_column :reviews, :title
  end

  def down
    remove_column :reviews, :title
  end
end
