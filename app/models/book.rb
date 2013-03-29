class Book < ActiveRecord::Base
  attr_accessible :author, :description, :title, :book_type

  validates :title, presence: true
  validates :author, presence: true

  has_many :reviews, dependent: :destroy
  belongs_to :user

  has_many :likes
  has_many :users, through: :likes

  BOOK_TYPES = ["Fiction", "Mystery", "Fantasy", "Arts", "Business","History", "Sciences", "Health","Travel"]
  SEARCH_ALL = "All" 
  SEARCH_TYPE = "Type"
  SEARCH_AUTHOR = "Author"
  SEARCH_TITLE = "Title"
  SEARCH_TYPES = [SEARCH_ALL, SEARCH_TITLE, SEARCH_AUTHOR, SEARCH_TYPE]

  def self.search_for(search_type, keyword)
    search_condition = "%" + keyword + "%"
    if search_type == SEARCH_ALL
      find(:all, :conditions => ['title LIKE ? OR author LIKE ? OR book_type LIKE ?', search_condition, search_condition, search_condition])
  	elsif search_type == SEARCH_TYPE
      find(:all, :conditions => ['book_type LIKE ?',  search_condition])
  	elsif search_type == SEARCH_AUTHOR
      find(:all, :conditions => ['author LIKE ?', search_condition])
  	elsif search_type == SEARCH_TITLE
     find(:all, :conditions => ['title LIKE ?', search_condition])
  	else
  		[]
  	end
  end


end
