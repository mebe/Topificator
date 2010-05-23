class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.column :name, :string
      t.column :all_channels, :boolean
      t.column :access_key, :string, :length => 32
      t.column :user_id, :int
    end
  end
  
  def self.down
    drop_table :feeds
  end
end
