module SessionsHelper

  # Log in the group admin
  def log_in_group_admin(group)
    session[:group_email] = group.email
  end

  # Returns the currentloged-in group admin or nil 
  def current_admin
     @current_admin = @current_admin || Group.find_by(email: session[:group_email])
  end

  def current_admin_group
     @current_admin_group = current_admin
  end
  
# Returns true if the admin is logged in, false otherwise
   def admin_logged_in?
     !current_admin.nil?  # An admin is logged in if current_admin is not nil
   end

# logs out current admin
  def log_out_group_admin
       session.delete(:group_email)
       @current_admin_group = nil
  end
 
end
