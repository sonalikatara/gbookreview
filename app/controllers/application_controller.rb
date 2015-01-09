class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  include SessionsHelper # implementing sessions will involve defining a large number of related functions accross muliple controllers and view . So we make sessions functions available to all controllers by including it in Application controller and by making a helper we keep it clean in am module of it's own.

end
