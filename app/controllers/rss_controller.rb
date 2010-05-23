class RssController < ApplicationController
  skip_before_filter :authorize
  
  def index
    @feed = Feed.find_by_access_key(params[:access_key])
    unless @feed
      render :nothing => true, :status => 401
      return
    end
    
    if @feed.all_channels?
      @topics = Topic.find(:all, :order => 'created_at DESC', :limit => 10)
    else
      channel_ids = Array.new
      @feed.channels.each {|c| channel_ids << c.id}
      @topics = Topic.find(:all, :conditions => 'channel_id IN (' + channel_ids.join(', ') + ')',
                           :order => 'created_at DESC', :limit => 10)
    end
    @headers['Content-Type'] = 'application/rss+xml'
  end
end