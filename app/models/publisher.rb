class Publisher < ActiveRecord::Base

  require 'amqp'
  attr_accessible :first_name, :last_name, :email

  def self.publish_message exchange, user_params
    Publisher.create!(user_params)
    exchange.publish(user_params.to_json)
  end

  def self.get_message
  end
end
