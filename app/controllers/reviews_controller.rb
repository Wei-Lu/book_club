class ReviewsController < BooksController
  before_filter :find_book
  before_filter :find_review, only: [:show, :edit, :update, :destroy]

  def create
   @review = Review.new(params[:review])
   @review.book = @book
   @review.user = current_user
   if @review.save
#     BooksMailer.delay.review_notification(current_user, @book)
     BooksMailer.review_notification(current_user, @book).deliver
     redirect_to @book,notice: "Review created successfully!"
   else
     redirect_to @book, notice: "Review creation failed."
   end 	
  end


  def destroy
    if @review.destroy
    	redirect_to @book, notice: "Review entry is destroyed"
    else
    	redirect_to Reviews_path, notice: "Review entry deletion fails"
    end
  end

private

def find_review
  @review = Review.find(params[:id] )
end

end
