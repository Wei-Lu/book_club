class RemoveTitleFromReviews < ActiveRecord::Migration
  def up
    add_column :reviews, :title
  end

  def down
    remove_column :reviews, :title
  end
end
