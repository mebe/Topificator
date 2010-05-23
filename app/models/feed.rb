class Feed < ActiveRecord::Base
  has_and_belongs_to_many :channels
  belongs_to :user
  
  validates_presence_of :name
  validates_presence_of :channels, :if => Proc.new { |feed| !feed.all_channels }
  validates_uniqueness_of :name, :scope => 'user_id'
  
  before_create :generate_access_key
  def generate_access_key
    @attributes['access_key'] = MD5.hexdigest((object_id + rand(255)).to_s)
  end
  
  def after_find
    class <<self.channels
      def to_s
        self.join(' ')
      end
    end
  end
end
