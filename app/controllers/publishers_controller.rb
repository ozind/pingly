class PublishersController < ApplicationController

  def index
    @users = Publisher.all
  end

  def new
   @user = Publisher.new
  end

  def create
    rab_con = ApplicationController.get_amqp_client
    channel = AMQP::Channel.new(rab_con)
    exchange = channel.fanout("amq.fanout")
    channel.queue("create.user") do |queue, declare_ok|
      queue.bind(exchange)
    end
    Publisher.publish_message exchange, params[:publisher]
    redirect_to :action => :index
  end

end
