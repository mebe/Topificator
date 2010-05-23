class TopicController < ApplicationController
  skip_before_filter :authorize
  def index
    @topic = Topic.find_by_access_key(@params[:access_key])
    unless @topic
      render :nothing => true, :status => 401
      return
    end
  end
end
