class HomeController < ApplicationController

	def index
    	@books = Book.all
    	@book = Book.first
	    @review = Review.new
	    @like =  ( current_user && current_user.like_for(@book)) || Like.new


	    respond_to do |format|
	    	format.html { render action: 'index' }
	    end
	end

	def edit

	end

	def show_car
		@books = Book.all
    	@book = Book.find(params[:id])
	    @review = Review.new
	    @like =  ( current_user && current_user.like_for(@book)) || Like.new


	    respond_to do |format|
	    	format.html { render action: 'index' }
	    end
	end

end