class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.column :topic, :string
      t.column :topic_parsed, :text
      t.column :topic_cleaned, :string
      t.column :user, :string
      t.column :created_at, :datetime
      t.column :access_key, :string, :length => 32
      t.column :channel_id, :int
    end
  end
  
  def self.down
    drop_table :topics
  end
end