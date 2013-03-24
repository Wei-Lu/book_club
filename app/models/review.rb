class Review < ActiveRecord::Base
  attr_accessible :content, :title
  validates :content, presence: true
  belongs_to :book
end
