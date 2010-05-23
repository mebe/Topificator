class AddTopicsTriggerToChannels < ActiveRecord::Migration
  def self.up
    execute('
              CREATE TRIGGER update_topics BEFORE UPDATE ON anope_cs_info
              FOR EACH ROW
              BEGIN
                IF NEW.last_topic <> OLD.last_topic THEN
                  INSERT INTO topics (topic, user, created_at, access_key, channel_id) VALUES
                    (NEW.last_topic,
                     NEW.last_topic_setter,
                     FROM_UNIXTIME(NEW.last_topic_time),
                     MD5(CONCAT(NEW.ci_id, NEW.last_topic_time, RAND())),
                     NEW.ci_id);
                END IF;
              END;
            ')
  end

  def self.down
    execute('DROP TRIGGER update_topics')
  end
end
