class FeedController < ApplicationController
  def index
    list
  end
  
  def list
    @submit_button_text = 'Create!'
    render :action => :list
  end
  
  def del
    if (@feed = Feed.find_by_id(@params[:id])) && (@feed.user_id == @user.nc_id)
      @feed.destroy
      if request.xhr?
        render :partial => 'update_feeds_after_delete'
      else
        @flash[:note] = 'Feed deleted!'
        redirect_to :action => :index
      end
    end
  end
  
  def edit
    @submit_button_text = 'Update!'  
    
    if (@feed = Feed.find_by_id(@params[:id])) && (@feed.user_id == @user.nc_id)
      render :partial => 'show_feed_editor' if request.xhr?
    else
      @feed = nil
      @submit_button_text = 'Create!'
    end
  end
  
  def save
    if @params[:id]
      @feed = Feed.find_by_id(@params[:id])
    else
      @feed = Feed.new
    end
    edit = !@feed.new_record?
    
    @feed.name = params[:feed][:name]
    @feed.user = @user
    @feed.channels.clear
    
    if params[:feed][:all_channels] == '1'
      @feed.all_channels = true
    else
      @feed.all_channels = false
      if @params[:feed][:channels]
        @params[:feed][:channels].each { |channel|
          @feed.channels << Channel.find(channel)
        }
      end
    end
    
    if @feed.save
      if request.xhr?
        if edit
          render :partial => 'update_feeds_after_edit'
        else
          render :partial => 'update_feeds_after_new'
        end
      else
        flash[:note] = 'New feed created!'
        redirect_to :action => :index
      end
    else
      if request.xhr?
        if edit
          @error_field = "feed_#{@feed.id}_editor_errors"
        else
          @error_field = "new_feed_editor_errors"
        end
        render :partial => 'show_feed_editor_errors'        
      else
        @submit_button_text = 'Try again!'
        render :action => :edit
      end
    end
  end
end