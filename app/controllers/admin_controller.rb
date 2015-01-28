class AdminController < ApplicationController
  def index
     @group = current_admin_group
     @readers = current_admin_group.reader
  end
end
