class HomeController < ApplicationController
  def index
      @items =Item.last(3)


      @tour_current = Tour.order(:id).last(2)[0]

      @results_current = Schedule.where(tour_id: @tour_current.id)

      @tour_future = Tour.order(:id).last
      @schedules_future = Schedule.where(tour_id: @tour_future.id)

      @league = League.all
  end
  def contact
      @text = Contact.all
  end

  def referee
      @text = Referee.all
  end
  def item
      @items = Item.last(20)
  end
  
  def table_result
      if current_user.present? && current_user.active_admin
          @table_result = TableResult.where(league_id: League.first.id).order(:place)
      end
  end
  
end
