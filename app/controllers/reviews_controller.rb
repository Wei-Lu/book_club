class ReviewsController < BooksController
  before_filter :find_book
  before_filter :find_review, only: [:show, :edit, :update, :destroy]
=begin
def index
  @reviews = Review.all
end

def show
#    @review = Review.new
  	# render :text => "in show"
  end
  
  def new
  	@review = Review.new
  end
=end
  def create
   @review = Review.new(params[:review])
   @review.book = @book
   if @review.save
     redirect_to @book,notice: "Review created successfully!"
   else
    render action :new
   end 	
  end

=begin
  def edit
    @review = Review.find(params[:id])    
  end
  
  def update
   if @review.update_attributes(params[:review])
     redirect_to @review,notice: "Review updateed successfully!"
   else
    render :new
   end 
  end
=end

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
