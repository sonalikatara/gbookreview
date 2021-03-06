class GroupsController < ApplicationController
 # before_action :logged_in_reader, only: [:show]

 
def new
  @group = Group.new
end

def create
   @group = Group.new(group_params)

    if @group.save
       # send the admin and group a welcome email
      log_in_group_admin(@group)
      redirect_to @group, alert: "Group #{@group.groupName} was sucessfully created."
      GroupRequestMail.invited(@group).deliver
   else
      render 'new'  
   end
end


def show
   session[:group_id] = params[:group_id]
   @group = current_admin_group || current_group
   @readers = @group.reader.all
end

def myGroup
    @group = Group.new
end

def showmygroup
     if @group=Group.find_by(groupName: params[:groupName] )
       redirect_to @group
     else
       redirect_to my_group_path , alert: "Group not Found. Check your spelling and casses."
    end
end

def allgroups
  @groups = Group.all.order('created_at DESC')
end

# sending group request from a new Admin
def startgroup
  @group = Group.new
end

def mailstartgrouprequest
   @group = Group.new(group_params)

   # to add:: check for errors in Group form

   if (@group)
       GroupRequestMail.received(@group).deliver
       redirect_to root_path, alert: " Your request is sent to the Admin. You will recieve a welcome email from us soon."
   else
       render 'new'
   end 

end

private
 
def group_params
  params.require(:group).permit(:groupName, :email, :email_confirmation, :password, :password_confirmation, :groupPassword, :groupPassword_confirmation, :picture, :description, :grouppicture)
end

end
