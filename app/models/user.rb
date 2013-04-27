class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :name, :password_confirmation, :remember_me
  attr_accessible :is_admin
  attr_accessible :pic
  has_attached_file :pic, :styles => 
    { 
      thumb: '50x50>',
      square: '200x200#',
      medium: '300x300>',
      :default_url => '/no_avatar.jpg'
    }


  validates_uniqueness_of :email
  validates_format_of :email, :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
 
  #has_many :books
  has_many :reviews
  has_many :likes
  has_many :liked_books, through: :likes, source: :book

  def has_liked?(book)
    liked_books.include?(book)
  end

  def like_for(book)
    likes.where(book_id: book.id).first
  end

  def self.find_user(review)
    User.all.where( user_id: review.user_id).first
  end
end