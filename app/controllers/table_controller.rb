class TableController < ApplicationController
    before_action :set_initial
    def team_position       
        @table_results = TableResult.where(league_id: params[:id]).order(:place)
    end   
    
    def match_result
        @teams = Team.where(league_id: params[:id])        
    end
    def goal_leader        
        @leaders = GoalLeader.joins(:team).where('teams.league_id=?', params[:id]).order('goal_leaders.goal desc')
    end
    
    def summary
        teams = Team.where(league_id: params[:id]).pluck(:id)
        @summary = Schedule.finished.where(guest_team_id: teams)
        @tours = Tour.where(id:@summary.pluck(:tour_id).uniq).order(created_at: :desc)
    end
   private
    def set_initial
      @league_name = League.find(params[:id]).name
      @league = League.order(id: :desc)
    end
end
