module FeedHelper
  def id
    id = @feed ? @feed.id : 0
  end
  
  def selection(target)
    if target == :all
      object = 'all'
      collection = Channel.find(:all,
        :conditions => "ci_id NOT IN (SELECT channel_id FROM channels_feeds WHERE feed_id = #{id})")
      dom_id = "all_channels_for_#{id}"
    else
      object = 'feed'
      collection = @feed ? @feed.channels : nil
      dom_id = "feed_#{id}_channels"
    end
    options = {:id => dom_id, :multiple => true, :size => 10, :style => 'width: 10em;',
               :name => "#{object}[channels][]"}
    if collection
      collection_select object, 'channels', collection, 'id', 'name', {},
                        options
    else
      select object, 'channels', {}, {}, options
    end
  end
  
  def to_button
    button_to_function '<--', "mover_#{id}.addToFeed();", :id => "to_feed_#{id}"
  end
  
  def from_button
    button_to_function '-->', "mover_#{id}.removeFromFeed();", :id => "from_feed_#{id}"
  end
end