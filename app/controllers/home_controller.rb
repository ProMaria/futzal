class HomeController < ApplicationController
  def index
      @items =Item.last(3)
      @results = Schedule.where("result !=''").last(10)
      @schedule = Schedule.where("result =''").last(10)
  end
end
