class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def self.get_amqp_client
    @client = nil
    AMQP.start(ENV['RABBITMQ_BIGWIG_URL']) do |client|
      @client ||= client
      # connection is open and ready to be used
    end    
    @client
    # pub_exchange = nil    
    # AMQP.start(:host => '127.0.0.1', :port => 5672, :vhost => '/') do |connection, open_ok|
    #   channel = AMQP::Channel.new(connection)
    #   exchange = channel.fanout("amq.fanout")
    #   channel.queue("", :auto_delete => true, :exclusive => true) do |queue, declare_ok|
    #     queue.bind(exchange)
    #     puts "Bound #{queue.name} to #{exchange}"
    #     # exchange.publish("This is a warmup message from rails!")
    #     pub_exchange = exchange        
    #   end
    # end    
    # pub_exchange
  end
end
