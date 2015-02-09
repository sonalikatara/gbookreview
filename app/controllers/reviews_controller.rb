
class ReviewsController < ApplicationController
 before_action :logged_in_reader, only: [:create, :destroy]


 def index
    if (params[:search_string])
      @reviews = search_review(params[:search_string])
    else
      @reviews = Review.all
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
  #  puts review_params
     @reader= current_reader
     @review = current_reader.review.build(review_params)
   if @review.save
     redirect_to show_reader_path @reader, notice: 'Review Saved. Thank You for sharing your Review!!'
   else
    render action: "new" 
   end
  end


  def searchbooks  # lists all the books
    @reviews = Review.all.group("title")
    #  Review.find(:all, :conditions => ["title in ?", @reviews])
  end

  def showbook # show a book and all it's reviews
    search_title = params[:title]
    @reviews = Review.find(:all, :conditions => [ "title = ? ", "#{search_title}" ]) 
  end

  def showreader # show a reader and all the reviews written 
    search_reader = params[:reader_id]
    @reader = Reader.find(search_reader)
    @reviews = Review.find(:all, :conditions => ["reader_id = ? ", "#{search_reader}"])
  end

  def showauthor # shows a author and list of reviews on his/her books
    search_author = params[:author]
    @reviews =Review.find(:all, :conditions => ["author = ?", "#{search_author}"])
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
         '"1.png", alt: "Not Good"'
   elsif rating == '2' 
         '"2.png", alt:"Loved it"'
   elsif rating == '3' 
         '"3.png", alt:"Got to Read"'
   end
  end

  private
  def review_params
     params.require(:review).permit( :title, :author, :picture, :rating,:comment, :bookcover)
  end

  def search_review(query)   #searches the records for a query
       Review.find(:all, :conditions => ["title like ? OR author like ?","%#{query}%", "%#{query}%"])
  end



 end
