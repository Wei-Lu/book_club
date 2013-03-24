class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :book_id
      t.integer :review_id

      t.timestamps
    end
  end
end
