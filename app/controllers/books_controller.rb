require 'google_chart' 

class BooksController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :search, :sort, :ratings]
  before_filter :find_book, only: [:show, :edit, :update, :destroy]
  before_filter :noadmin_redirect, only: [:new, :edit, :update, :create, :destrory] 
  # GET /books
  # GET /books.json
  def index
    @books = Book.all.sort_by(&:likes_count).reverse.map    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  def ratings
    @books = Book.all.sort_by(&:likes_count).reverse.map
    
    # Need to clean up this code
    # OK for now, prototype code, just needs to work
    bar_1_data = []
    names_array = []
    pc_data = {}

    i = 0
    @books.each do |book|
      h1 = { book.title + ' by ' + book.author => book.likes.count }
      pc_data = pc_data.merge(h1)
      i = i + 1
      if i == 5 
        break;
      end
    end

    # pc.data key, value
    h = pc_data.length * 55 + 50 
    lc = GoogleChart::BarChart.new("700x" + h.to_s, "", :horizontal, false)
      lc.show_legend = false
      lc.axis :x, :color => '333333', :font_size => 10, :alignment => :center, :range => [0,pc_data.values.max]
      lc.axis :y, :color => '333333', :font_size => 20, :alignment => :right, :labels => pc_data.keys.reverse
      lc.width_spacing_options(:bar_width => 50, :bar_spacing => 5) 
      lc.data "Books", pc_data.values, '3caae8'
    
    @chart_url = lc.to_url

    respond_to do |format|
      format.html # ratings.html.erb
      format.json { render json: @chart_url }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
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
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
      end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create
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
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    if @book.destroy
      respond_to do |format|
        format.html { redirect_to books_url, notice: "Book entry is deleted successfully"  }
        format.json { head :no_content }
      end
    else
      format.html { redirect_to books_url, notice: "Book entry is not deleted."  }
    end
  end

  def search
    @search_type = params[:search_type]
    @books = Book.search_for params[:search_type], params[:search]
  end

  def sort
    @sort_type = params[:sort_type]
    @books = Book.all_ordered params[:sort_type]
  end

  private

  def find_book
    @book = Book.find( params[:book_id] || params[:id])
  end
end
