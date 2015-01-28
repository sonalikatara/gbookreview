class SessionsController < ApplicationController

  def new
    if reader_logged_in?
      log_out_reader
    end
  end
 
 def newReader
    if admin_logged_in?
       log_out_group_admin
    end
    @group = current_group
    @reader = Reader.find(params[:reader_id])
 end

  def createReaderGroup
    reader = Reader.find(params[:reader_id])
    group = current_group 

    if reader && Group.authenticateReader(group,params[:groupPassword])
      log_in_reader(reader,group)
      redirect_to show_reader_path reader
   else
     redirect_to reader_login_path , alert: "Invalid Group/Password combination !" 
   end

  end

  def create
    group = Group.find_by(email: params[:email].downcase)
    
    if group and group.authenticate(params[:password])
         # login group_admin and redirect to first page
         log_in_group_admin group
         redirect_to admin_home_path
    else
         # show an error message
         redirect_to admin_login_path , alert: "Invalid Email/Password combination !"
    end


  end

  def destroy
    #  session[:user_id] = nil
    # self.user = nil
     log_out_group_admin
     redirect_to root_url
  end
  
  def destroyReader
     log_out_reader
     redirect_to root_url
  end
end
