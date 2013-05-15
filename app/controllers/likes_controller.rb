class LikesController < BooksController
  before_filter :find_book

  def create
    @like = Like.new
  	@like.user = current_user
  	@like.book = @book  
  	if !current_user.has_liked?(@book) && @like.save
  	  redirect_to @book, notice: "You Liked the book! Thanks"
  	else
  	  redirect_to @book, alert: "Sorry you couldn't like it!!"
  	end    	
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.destroy
      redirect_to @book, notice: "You UnLiked the book!"
    else
      redirect_to @book, notice: "Sorry you couldn't unlike it!"
    end  	
  end

  def noadmin_redirect
  end

end
