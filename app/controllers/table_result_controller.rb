class TableResultController < ApplicationController
    before_action :check_admin
    def generate
        TableResult.where(league_id: params[:league_id]).delete_all
        Team.where(league_id: params[:league_id]).each do |team|
            counter_all, counter_win, counter_pat, counter_lost,counter_ball_create,counter_ball_lost = team.count_games
            TableResult.create(team_id:team.id, league_id: params[:league_id], count_game: counter_all, count_win: counter_win,
                  count_pat: counter_pat, count_lost: counter_lost, count_ball_create: counter_ball_create,  
                               count_ball_lost: counter_ball_lost, score: counter_win*3+counter_pat, sub_ball: counter_ball_create- counter_ball_lost)              
        end 
        place = 1
        TableResult.where(league_id: params[:league_id]).order(score: :desc, sub_ball: :desc).each do |result|
            result.update_attribute(:place, place)
            place+=1
        end
        redirect_to table_path(params[:league_id])
    end
    private
    def check_admin
        redirect_to root_path unless current_user.present? && current_user.active_admin
    end
    
    
end
