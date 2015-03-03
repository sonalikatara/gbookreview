class ReadersController < ApplicationController
    
   before_action :logged_in_group_admin, only: [:new, :create, :destroy, :edit, :update]

   def new
      @reader = current_admin_group.reader.build
      @group = current_admin_group
   end
   
   def create
      @group = current_admin_group
      @reader = current_admin_group.reader.build(reader_params)
      if @reader.save
          GroupRequestMail.welcomeReader(@reader,@group).deliver

         flash[:sucess] = "Reader created!"
         redirect_to admin_home_url
      else
         render new_reader_path
      end 
   end
   
   def edit
      @group = current_admin_group
      @reader = Reader.find(params[:id])
   end
  
   def update
     @group = current_admin_group
     @reader = Reader.find(params[:id])
     if @reader.update(reader_params)
        flash[:sucess] = "Changes saved !"
        redirect_to admin_home_path
     else
       render 'edit'
     end 

   end

    def show 


   end

   def destroy
   end

  
  private

   def reader_params
      params.require(:reader).permit(:readerName, :email, :email_confirmation , :readerpicture)
   end
end
