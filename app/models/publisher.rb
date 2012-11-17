class Publisher < ActiveRecord::Base

  require 'amqp'
  attr_accessible :message

  def self.publish_message exchange, msg
    exchange.publish(msg)
  end

  def self.get_message
  end
end
