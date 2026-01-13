class PagesController < ApplicationController
  def home
    @subscriber = Subscriber.new
  end
end
