#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "development"

require File.dirname(__FILE__) + "/../../config/application"
Rails.application.require_environment!

$running = true
Signal.trap("TERM") do 
  $running = false
end

#while($running) do
  EventMachine.run do
    #connection = AMQP.connect(:host => '127.0.0.1', :port => 5672, :vhost => '/')
    connection = AMQP.connect(ENV['RABBITMQ_BIGWIG_URL'])
    channel = AMQP::Channel.new(connection)
    exchange = channel.fanout("amq.fanout")
    queue = channel.queue("my.test")
    queue.bind(exchange)
    queue.subscribe do |payload|
      obj = eval(payload)['message']
      puts obj
      Rails.logger.auto_flushing = true
      Rails.logger.info "This daemon is still running at #{Time.now}.\n"
      Publisher.create!(:message => obj)
      puts Publisher.all.count
      puts "***********************************"
      #connection.close {
      #   EventMachine.stop { exit }
      #}
    end
  end
#end