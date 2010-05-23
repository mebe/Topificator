class Channel < ActiveRecord::Base
  set_table_name 'anope_cs_info'
  set_primary_key 'ci_id'
  has_and_belongs_to_many :feeds
  has_many :topics
  
  def to_s
    self.name
  end
  
  def Channel.find_many_by_name(string)
    unless string
      return Array.new
    end
    channel_strings = string.gsub(',', '').split(/\s/)

    channels = Array.new
    
    channel_strings.each { |channel|
      channel = Channel.find_by_name(channel)
      channels << channel if channel
    }
    return channels
  end
end
