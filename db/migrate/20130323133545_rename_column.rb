class RenameColumn < ActiveRecord::Migration
  def up
     rename_column :books, :type, :book_type
 end

  def down
  end
end
