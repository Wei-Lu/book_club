class Book < ActiveRecord::Base
  attr_accessible :author, :description, :title, :book_type

  validates :title, presence: true
  validates :author, presence: true

  has_many :reviews, dependent: :destroy
  
  has_attached_file :pic, :styles => 
           { :medium => "300x400>", :thumb => "100x100>" }
  has_attached_file :attach
  attr_accessible :pic, :attach

  has_many :likes
  has_many :users, through: :likes

  BOOK_TYPES = ["Fiction", "Mystery", "Fantasy", "Arts", "Business","History", "Sciences", "Health","Travel"]
  SEARCH_ALL = "All" 
  SEARCH_TYPE = "Type"
  SEARCH_AUTHOR = "Author"
  SEARCH_TITLE = "Title"
  LIKES_COUNT = "Likes Count"
  SEARCH_TYPES = [SEARCH_ALL, SEARCH_TITLE, SEARCH_AUTHOR, SEARCH_TYPE]
  ORDER_TYPES = [LIKES_COUNT, SEARCH_TITLE, SEARCH_AUTHOR, SEARCH_TYPE]
  def self.search_for(search_type, keyword)
    search_condition = "%" + keyword + "%"
    if search_type == SEARCH_ALL
      find(:all, :conditions => ['title LIKE ? OR author LIKE ? OR book_type LIKE ?', search_condition, search_condition, search_condition])
  	elsif search_type == SEARCH_TYPE
      find(:all, :conditions => ['book_type LIKE ?',  search_condition], :order =>'title ASC')
  	elsif search_type == SEARCH_AUTHOR
      find(:all, :conditions => ['author LIKE ?', search_condition])
  	elsif search_type == SEARCH_TITLE
     find(:all, :conditions => ['title LIKE ?', search_condition])
  	else
  		[]
  	end
  end

  def self.all_ordered(order_type=SEARCH_ALL)
    if order_type == LIKES_COUNT
      all.sort_by(&:likes_count).reverse.map    
    elsif order_type == SEARCH_TITLE
      find(:all, :order =>'title ASC')
    elsif order_type == SEARCH_AUTHOR
      find(:all, :order =>'author ASC')
    elsif order_type == SEARCH_TYPE
     find(:all, :order =>'book_type ASC')
    else
      []
    end
  end

  def likes_count
    likes.count
  end  

end
