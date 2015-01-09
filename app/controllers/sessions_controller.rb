class SessionsController < ApplicationController

  def new
 
 end

  def create
      group = Group.find_by(email: params[:email].downcase)
    
    if group and group.authenticate(params[:password])
         # login group_admin and redirect to first page
         log_in_group_admin group
         redirect_to admin_url
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
end
