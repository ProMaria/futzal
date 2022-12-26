require 'date'
class HomeController < ApplicationController
  def index
      @items =Item.last(3)
      # leagues = League.all()
      # leaders = GoalLeader.select("teams.league_id as league_id, max(goal_leaders.goal) as max_goal").joins(:team).where("teams.league_id in (?)", leagues.pluck(:id)).group("teams.league_id")
      
      # max_goals = {}
      # for res in leaders
      #   max_goals[res.league_id] = res.max_goal
      # end
      # puts(max_goals)
      # lead = GoalLeader.select("leagues.name as league, leagues.id as league_id, fio, goal").joins('join teams on teams.id = goal_leaders.team_id join leagues on leagues.id = teams.league_id').where("goal in (?) and teams.league_id in (?)", max_goals.values, max_goals.keys).order("league")
      # @all_leaders = []
      # for res in lead
      #   if max_goals[res.league_id] == res.goal          
      #     @all_leaders << res
      #   end
      # end

      @last_games = Schedule.where("timestamp between ? AND ?", Date.today - 7, Date.today)
      @future_games = Schedule.where("timestamp between ? AND ? or timestamp is null", Date.today+1, Date.today + 30)
      @current_games = Schedule.where("timestamp between ? AND ?", Date.today, Date.today+1)
       
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
