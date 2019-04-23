class HomeController < ApplicationController
  def index
      @items =Item.last(3)
      @result_semifinal = Schedule.where(tour_id: Tour.semifinal_tours)

      @tour_current = Tour.current_tours.order(:id).last(1)[0]

      @results_current = Schedule.where(tour_id: @tour_current.id) if !@result_semifinal.first.result.present?

      @tour_future = Tour.current_tours.order(:id).last
      @schedules_future = nil
      Schedule.where(tour_id: @tour_future.id) if @tour_future.name.match('тур')

      @league = League.all

      @result_final = Schedule.where(tour_id: Tour.final_tours)
      @result_final_third = Schedule.where(tour_id: Tour.third_tours)
      
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
