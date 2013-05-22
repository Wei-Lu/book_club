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
  ALL = "All" 
  TYPE = "Type"
  AUTHOR = "Author"
  TITLE = "Title"
  LIKES_COUNT = "Likes Count"
  SORT_BY = "Sort by "
  SEARCH_TYPES = [ALL, TITLE, AUTHOR, TYPE]
  ORDER_TYPES = [SORT_BY+LIKES_COUNT, SORT_BY+TITLE, SORT_BY+AUTHOR, SORT_BY+TYPE]
  def self.search_for(search_type, keyword)
    search_condition = "%" + keyword + "%"
    if search_type == ALL
      find(:all, :conditions => ['title LIKE ? OR author LIKE ? OR book_type LIKE ?', search_condition, search_condition, search_condition])
  	elsif search_type == TYPE
      find(:all, :conditions => ['book_type LIKE ?',  search_condition], :order =>'title ASC')
  	elsif search_type == AUTHOR
      find(:all, :conditions => ['author LIKE ?', search_condition])
  	elsif search_type == TITLE
     find(:all, :conditions => ['title LIKE ?', search_condition])
  	else
  		[]
  	end
  end

  def self.all_ordered(order_type=SEARCH_ALL)
    if order_type == SORT_BY+LIKES_COUNT
      all.sort_by(&:likes_count).reverse.map    
    elsif order_type == SORT_BY+TITLE
      find(:all, :order =>'title ASC')
    elsif order_type == SORT_BY+AUTHOR
      find(:all, :order =>'author ASC')
    elsif order_type == SORT_BY+TYPE
     find(:all, :order =>'book_type ASC')
    else
      []
    end
  end

  def likes_count
    likes.count
  end  

end
