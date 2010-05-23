# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  before_filter :authorize
  
  def authorize
    unless session[:user_id] && @user = User.find_by_nc_id(session[:user_id])
      session[:target_action] = action_name
      session[:target_controller] = controller_name
      redirect_to :controller => 'login'
    end
  end
end  