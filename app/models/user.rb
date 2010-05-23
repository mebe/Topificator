class User < ActiveRecord::Base
  set_table_name 'anope_ns_core'
  set_primary_key 'nc_id'
  has_many :feeds
  
  def name
    @attributes['display']
  end
end