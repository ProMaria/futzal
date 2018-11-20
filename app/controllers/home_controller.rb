class HomeController < ApplicationController
  def index
      @items =Item.last(3)

      results = Schedule.finished.last(10)
      @tours = Tour.where(id:results.pluck(:tour_id).uniq.sort.last)

      schedule = Schedule.start.last(10)
      @tours_future = Tour.where(id:schedule.pluck(:tour_id).uniq)

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
