class Book < ActiveRecord::Base
  attr_accessible :author, :description, :title, :book_type

  has_many :reviews, dependent: :destroy
  belongs_to :user

  has_many :likes
  has_many :users, through: :likes

end
