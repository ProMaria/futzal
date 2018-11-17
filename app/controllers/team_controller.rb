class TeamController < ApplicationController
  def index
      @teams = Team.where(league_id: params[:league_id]).order(:name)
  end

  def show
      @team = Team.find(params[:id])
      @players = @team.players
      @result = TableResult.find_by_team_id(params[:id])
      @goal_leaders = GoalLeader.where(team_id: params[:id])

  end
end
