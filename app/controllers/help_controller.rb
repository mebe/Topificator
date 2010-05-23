class HelpController < ApplicationController
  skip_before_filter :authorize
  layout :determine_layout
  #  layout 'help-lightbox'
  
  def index
    begin
      render :action => @params[:document]
    rescue
      render :action => 'no_help'
    end
  end  
  
  def determine_layout
    request.xhr? ? 'help-lightbox' : 'help-normal'
  end
end