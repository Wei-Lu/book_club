class Like < ActiveRecord::Base
  attr_accessible :book_id, :user_id
  belongs_to :user
  belongs_to :book
end
