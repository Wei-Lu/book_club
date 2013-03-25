class Book < ActiveRecord::Base
  attr_accessible :author, :description, :title, :book_type

  has_many :reviews, dependent: :destroy
  belongs_to :user

  has_many :likes
  has_many :users, through: :likes

  BOOK_TYPES = ["Fiction", "Mystry", "Fantisy", "Arts", "Business","History", "Sciences", "Health","Travel"]

  SEARCH_TYPE = "Type"
  SEARCH_AUTHOR = "Author"
  SEARCH_TITLE = "Title"
  SEACRCH_TYPES = [SEARCH_TYPE, SEARCH_AUTHOR, SEARCH_TITLE]
  
  def self.search_for(search_type, keyword)
  	if search_type == SEARCH_TYPE
      Book.where(book_type: keyword )
  	elsif search_type == SEARCH_AUTHOR
      Book.where(author: keyword )
  	elsif search_type == SEARCH_TITLE
      Book.where(title: keyword )
  	else
  		[]
  	end
  end

  def self.search(search)
	  search_condition = "%" + search + "%"
	  find(:all, :conditions => ['title LIKE ? OR author LIKE ? OR book_type LIKE ?' , search_condition, search_condition, search_condition])
  end


end
