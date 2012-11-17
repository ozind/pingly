require 'amqp'

EM.next_tick do
  #RABBIT_CON = AMQP.start(:host => '127.0.0.1', :port => 5672, :vhost => '/')
  RABBIT_CON = AMQP.start(ENV['RABBITMQ_BIGWIG_URL'])
end

#system("lib/daemons/poller_ctl start")

