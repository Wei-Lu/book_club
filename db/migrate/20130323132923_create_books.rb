class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :type
      t.text :description

      t.timestamps
    end
  end
end