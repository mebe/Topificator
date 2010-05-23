class Topic < ActiveRecord::Base
  belongs_to :channel

  def after_find
    require 'mirc_codes'
    self.topic.extend MircCodes
    unless self.topic_parsed? && self.topic_cleaned?
      self.topic_parsed = self.topic.mirc_to_html
      self.topic_cleaned = self.topic.strip_mirc
      self.save!
    end
  end
end