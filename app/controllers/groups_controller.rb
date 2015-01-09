class GroupsController < ApplicationController
 
def new
  @group = Group.new
end

def create
   @group = Group.new(group_params)

  # if @group.groupPassword.blank ?
  #    @group.groupPassword:  @group.password # password being the admin password
  # end

   if @group.save
       # send the admin and group a welcome email
      log_in_group__admin(@group)
      redirect_to @group, alert: "Group #{@group.groupName} was sucessfully created."
   else
      render 'new'  
   end
end

def show
   @group = current_admin_group
end


def allgroups
  @groups = Group.all.order('created_at DESC')
end
private
 
def group_params
  params.require(:group).permit(:groupName, :email, :email_confirmation, :password, :password_confirmation, :groupPassword, :groupPassword_confirmation, :picture, :description)
end

end
