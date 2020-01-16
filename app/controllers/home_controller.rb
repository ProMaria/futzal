class HomeController < ApplicationController
  def index
      @items =Item.last(3)
      # @result_semifinal = Schedule.where(tour_id: Tour.semifinal_tours)

      @tour_current = Tour.current_tours.order(:id).last(2)[0]

      @results_current = Schedule.where(tour_id: @tour_current.id).where('result is not null') if @tour_current.present? 
      # && !(@result_semifinal.present? && @result_semifinal.first.result.present?)

      @tour_future = Tour.current_tours.order(:id).last

      @next_tours = Tour.current_tours.order(:id).last(3)
      
      @schedules_future = Schedule.where(tour_id: @tour_future.id) if @tour_future.present? && Schedule.where(tour_id: @tour_future.id).where("result !=''").blank?

      if @tour_future.present? && Schedule.where(tour_id: @tour_future.id).where("result !=''").present?
        @results_current = Schedule.where(tour_id: @tour_future.id) 
        @tour_current = Tour.find(@tour_future.id)
        @schedules_future = []
        @tour_future = []
      end
      
      # && @tour_future.name.match('тур')

      @league = League.all

      # @result_final = Schedule.where(tour_id: Tour.final_tours)
      # @result_final_third = Schedule.where(tour_id: Tour.third_tours)
      @history_seasons = Season.unscoped.where(current: false)
      @history_teams = Team.where(league_id: League.unscoped.joins(:season).where('seasons.current is false').ids)
      @history_photos = Photo.unscoped.where(tour_id: Tour.unscoped.joins(:season).where('seasons.current is false').ids)
  
      @result_qfinal = Schedule.joins(:tour).where("tours.name ~ '1/4'")  
      @result_sfinal = Schedule.joins(:tour).where("tours.name ~ '1/2'")
      @result_third = Schedule.joins(:tour).where("tours.name ~ '3 место'")
      @result_final = Schedule.joins(:tour).where("lower(tours.name) = 'финал'") 

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
