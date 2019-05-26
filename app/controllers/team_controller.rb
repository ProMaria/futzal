class TeamController < ApplicationController
  def index
      @teams = Team.unscoped.where(league_id: params[:league_id]).order(:name)
  end

  def show
      @team = Team.unscoped.find(params[:id])
      @league_name=League.unscoped.find(@team.league_id).name
      
      @players = @team.players
      @result = TableResult.unscoped.find_by_team_id(params[:id])
      @goal_leaders = GoalLeader.unscoped.where(team_id: params[:id])

  end
end
