class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def self.get_amqp_client
    @client = nil
    AMQP.start(ENV['RABBITMQ_BIGWIG_URL']) do |client|
      @client ||= client
    end    
    @client
  end
end
