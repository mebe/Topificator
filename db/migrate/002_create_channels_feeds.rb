class CreateChannelsFeeds < ActiveRecord::Migration
  def self.up
    create_table :channels_feeds, :id => false do |t|
      t.column :channel_id, :int
      t.column :feed_id, :int
    end
  end
  
  def self.down
    drop_table :channels_feeds
  end
end
