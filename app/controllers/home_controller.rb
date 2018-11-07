class HomeController < ApplicationController
  def index
      @items =Item.last(3)
      @results = Schedule.where("result !=''").last(10)
      @schedule = Schedule.where("result =''").last(10)
      @league = League.all
  end
  def contact
      @text = Contact.all
  end

  def referee
      @text = Referee.all
  end
  def item
      @items = Item.order(:created_at)      
  end
  
  def table_result
      if current_user.present? && current_user.active_admin
          @table_result = TableResult.where(league_id: League.first.id).order(:place)
      end
  end
  
end
