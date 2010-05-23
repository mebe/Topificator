class LoginController < ApplicationController
  skip_before_filter :authorize
  
  def index
    render :action => :login
  end
  
  def login
    if params[:name]
      user = User.find_by_display_and_pass(params[:name], params[:pass])
      if user
        session[:user_id] = user.nc_id
        if session[:target_controller] && session[:target_action]
          redirect_to :controller => session[:target_controller], :action => session[:target_action]
        else
          redirect_to :controller => 'feed', :action => :index
        end
      else
        flash[:login] = 'Incorrect username or password!'
      end
    end
  end
  
  def logout
    reset_session
    flash[:login] = 'Loggerified out!'
    redirect_to :action => :index
  end  
end