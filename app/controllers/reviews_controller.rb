
class ReviewsController < ApplicationController
 before_action :logged_in_reader, only: [:create, :destroy]
 ratings_in_word = {"1" => "Didn't Like it","2" => "Liked It", "3" => "Loved It"}


 def index
    if params[:search_string]
       @reviews = search_review(params[:search_string]).paginate(page: params[:page], per_page: 10)
    elsif admin_logged_in?
          @reviews = Review.from_group(current_admin_group.id).paginate(:page => params[:page],:per_page => 10)
    else
       @reviews = Review.paginate(:page => params[:page],:per_page => 10)
    end

    if reader_logged_in?
      @reader = current_reader
    end
 end


 def new
    @reader = current_reader
    @review = current_reader.review.build 
 end
  

  def create # creates a new review record
     @reader= current_reader
     @review = current_reader.review.build(review_params)
   if @review.save
     # send email to the parent/gaurdian
       GroupRequestMail.emailReviewToReader(@reader,@review).deliver


     redirect_to show_reader_path @reader, notice: 'Review Saved. Thank You for sharing your Review!!'

   else
    render action: "new" 
   end
  end


  def searchbooks  # lists all the books
 
   #   books_read = Review.group(:title).avg(CAST(:ratings AS INTERGER)).count(:title).first
      
#   @books = Review.all.to_a.uniq{ |review| review.title }
 #     book_groups = Review.items.group_by(&:title)
 #     books_group.each do |title,average_rating,readers_count,review|
       
 #     end 
 
             
      @books = Review.select("*").merge(Review.group(:title).select( "  AVG(CAST(rating AS INTEGER)) as average_rating , COUNT(reviews.id) as readers_count"))
  #  Review.find(:all, :conditions => ["title in ?", @reviews])

    # @books = Review.group(:title).count(:rating)
  end

  def showbook # show a book and all it's reviews
    search_title = params[:title]
     if (current_admin_group)
       @reviews = Review.from_group(current_admin_group).of_book(search_title).paginate(page: params[:page], per_page: 4) # show only those from current group
    else
       @reviews = Review.of_book(search_title).paginate(page: params[:page], per_page: 4) 

    end
  end

  def showreader # show a reader and all the reviews written 
    search_reader = params[:reader_id]
     @reader = Reader.find_by(id: search_reader)    
    if  !(@reader.nil?) 
       @reviews = Review.from_reader(search_reader).paginate(page: params[:page], per_page: 4)
    else
       redirect_to root_path
    end

  end
 
  def showauthor # shows a author and list of reviews on his/her books
    search_author = params[:author]
    @reviews =Review.where("author = ?", "#{search_author}").paginate(page: params[:page], per_page: 4)
  end

  def show  # shows a review by taking an id

    @review = Review.find(params[:id])
 
  end


  def edit # edits a review
    @review = Review.find(params[:id]) 
     
  end

  
  def update #updates a review
    @reader = current_reader
    @review = Review.find(params[:id])
    
    if  @review.update(review_params) 
      redirect_to show_reader_path @reader, notice: 'Your review is now updated. '
    else
      render 'edit'
    end

  end

  def destroy # destroys a review record
   @review = Review.find(params[:id])
   @review.destroy
   redirect_to '/reviews/'
  end
  
 # def picture=(file_data)
 #    unless file_data.blank?
 #       @file_data = file_data
      
 #    end  
 # end 
 
  def ratings_image(rating)
   if rating == '1'
         '"1.png", alt: "Didnt like it"'
   elsif rating == '2' 
         '"2.png", alt:"Liked it"'
   elsif rating == '3' 
         '"3.png", alt:"Loved it"'
   end
  end

  private
  def review_params
     params.require(:review).permit( :title, :author, :category, :rating,:comment, :bookcover)
  end

  def search_review(query)   #searches the records for a query
       #Review.find(:all, :conditions => ["title like ? OR author like ?","%#{query}%", "%#{query}%"]) pagination doesn't work with find so changing to where
        Review.where( "title like ? OR author like ?","%#{query}%", "%#{query}%").paginate(page: params[:page])

  end


 end
