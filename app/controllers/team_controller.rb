class TeamController < ApplicationController
  def index
      @teams = Team.where(league_id: params[:league_id]).order(:name)
  end

  def show
      @team = Team.find(params[:id])
      @players = @team.players
  end
end
