class FutadminController < ApplicationController
    before_action :check_admin
     def generate
        TableResult.where(league_id: params[:league_id]).delete_all
        Team.where(league_id: params[:league_id]).each do |team|
            counter_all, counter_win, counter_pat, counter_lost,counter_ball_create,counter_ball_lost = team.count_games
            TableResult.create(team_id:team.id, 
                league_id: params[:league_id], 
                count_game: counter_all, 
                count_win: counter_win,
                  count_pat: counter_pat, 
                  count_lost: counter_lost, 
                  count_ball_create: counter_ball_create,  
                               count_ball_lost: counter_ball_lost,
                                score: counter_win*3+counter_pat, 
                                sub_ball: counter_ball_create- counter_ball_lost)              
        end 
        place = 1
        table_results = TableResult.where(league_id: params[:league_id]).pluck(:score).uniq!.sort! {|a, b| b <=> a}
        
        table_results.each do |score|           
            TableResult.where(league_id: params[:league_id], score: score).order(count_win: :desc, 
                sub_ball: :desc, count_ball_create: :desc).each do |result|
                
                team_score = result.score.to_s
                
                the_same_score_teams = TableResult.where(league_id: params[:league_id], score: team_score)  
                   
                if the_same_score_teams.count == 2
                    team_ids = the_same_score_teams.pluck(:team_id)
                    # приоритеты: 
                    # результат личной встречи
                    result_versus = Schedule.where(home_team_id: team_ids, guest_team_id: team_ids)
                    
                    if result_versus.pluck(:result).count == 1
                        result_versus = result_versus.first
                        home_team_id = result_versus.home_team_id
                        home_score = result_versus.split(':')[0]

                        guest_team_id = result_versus.guest_team_id
                        guest_score = result_versus.split(':')[1]

                        home_rec = the_same_score_teams.where(team_id: home_team_id).first
                        guest_rec = the_same_score_teams.where(team_id: guest_team_id).first

                        if home_score > guest_score
                            home_rec.update_attribute(:place, place)
                            place+=1
                            guest_rec.update_attribute(:place, place)
                        elsif home_score < guest_score
                            guest_rec.update_attribute(:place, place)
                            place+=1
                            home_rec.update_attribute(:place, place)
                        end
                    end
                else
                    result.update_attribute(:place, place)
                    place+=1
                    # наибольшее число побед во всех встречах
                    # лучшая разница мячей во всех встречах
                    # наибольшее количество забитых мячей во всех встречах
                end
            end
        end
        redirect_to team_position_table_path(params[:league_id])
    end
   
    private
    def check_admin
        redirect_to root_path unless current_user.present? && current_user.active_admin
    end
end
