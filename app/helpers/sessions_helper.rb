module SessionsHelper

  # Log in the group admin
  def log_in_group_admin(group)
    session[:group_email] = group.email
  end

 # Log in the reader
   def log_in_reader(reader,group)
      session[:group_id] = group.id
      session[:reader_id] = reader.id
   end
 

  #Returns the current group for readers
  def current_group
     @current_group = @current_group || Group.find(session[:group_id])
  end
  #Returns the currentreader
  def current_reader
    @current_reader ||= Reader.find_by(id: session[:reader_id])
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

# confirms an admin is logged in ..ie. if not redirects to login page
  def logged_in_group_admin
      unless admin_logged_in?
        flash[:alert] = "Please log in."
        redirect_to admin_login_path 
      end
  end

# if a reader is logged in returns true , false otherwise
   def reader_logged_in?
      !current_reader.nil?
   end

#confirms if a reader is logged in
  def logged_in_reader
      unless reader_logged_in?
         flash[:alert] = "Please log in as a reader."
         redirect_to my_group_path
      end
  end
  #logs out reader
    def log_out_reader
      session.delete(:group_id)
      session.delete(:reader_id)
      @current_reader =nil
    end

end
