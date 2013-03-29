
class BooksController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :search]
  before_filter :find_book, only: [:show, :edit, :update, :destroy]
  before_filter :set_is_current_user_admin

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
#    @books.sort_by do |book|
#      [book.title]
#    end
#    @books.sort_by(&:invertible)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
#    @book = Book.find(params[:id])
    @review = Review.new
    @like   = (current_user && current_user.like_for(@book)) || Like.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    if @is_current_user_admin
      @book = Book.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @book }
      end
    else
      redirect_to books_url, notice: "You must be an admin to create the book entry"      
    end
  end

  # GET /books/1/edit
  def edit
    if @is_current_user_admin
#  if(current_user && current_user.is_admin?)
      @book = Book.find(params[:id])
    else
      redirect_to books_url, notice: "You must be an admin to edit the book entry"      
    end
  end

  # POST /books
  # POST /books.json
  def create
    if @is_current_user_admin
      @book = Book.new(params[:book])

      respond_to do |format|
        if @book.save
          format.html { redirect_to @book, notice: 'Book was successfully created.' }
          format.json { render json: @book, status: :created, location: @book }
        else
          format.html { render action: "new" }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to books_url, notice: "You must be an admin to create the book entry"      
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
#    @book = Book.find(params[:id])

    if @is_current_user_admin
      respond_to do |format|
        if @book.update_attributes(params[:book])
          format.html { redirect_to @book, notice: 'Book was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    else
        redirect_to books_url, notice: "You must be an admin to update the book entry"      
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
#    @book = Book.find(params[:id])
    if @is_current_user_admin
      if @book.destroy
        respond_to do |format|
          format.html { redirect_to books_url, notice: "Book entry is deleted successfully"  }
          format.json { head :no_content }
        end
      else
        format.html { redirect_to books_url, notice: "Book entry is not deleted."  }
      end
    else
          redirect_to books_url, notice: "You must be an admin to delete book entry"      
    end
end

def search
  @search_type = params[:search_type]
  @books = Book.search_for params[:search_type], params[:search]
end

private

def find_book
  @book = Book.find( params[:book_id] || params[:id])
end

def set_is_current_user_admin
  @is_current_user_admin = (current_user && current_user.is_admin?)
end

end
