class TableController < ApplicationController
    def show
        @teams = Team.where(league_id: params[:id])
        @league = League.order(id: :desc)
        @leaders = GoalLeader.joins(:team).where('teams.league_id=?', params[:id]).order('goal_leaders.goal desc')
        @table_results = TableResult.where(league_id: params[:id]).order(:place)
    end
end
