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
        table_results = TableResult.where(league_id: params[:league_id]).distinct.pluck(:score)

        if table_results.present?
            
            table_results = table_results.sort! {|a, b| b <=> a}
            
            table_results.each do |score|           
                TableResult.where(league_id: params[:league_id], score: score).order(count_win: :desc, 
                    sub_ball: :desc, count_ball_create: :desc).each do |result|
                    
                    team_score = result.score.to_s
                    
                    the_same_score_teams = TableResult.where(league_id: params[:league_id], score: team_score)  
                       
                    if the_same_score_teams.count == 2
                        puts '*/***********' + 'place=' + place.to_s
                        team_ids = the_same_score_teams.pluck(:team_id)
                        # приоритеты: 
                        # результат личной встречи
                        result_versus = Schedule.where(home_team_id: team_ids, guest_team_id: team_ids)
                        
                        if result_versus.pluck(:result).count == 1
                            #puts '------------------------------------' + result_versus.pluck(:result).count.to_s
                            result_versus = result_versus.first
                            #puts '////' + result_versus.result.to_s
                            home_team_id = result_versus.home_team_id
                            home_score = result_versus.result.split(':')[0] if result_versus.result.present?

                            guest_team_id = result_versus.guest_team_id
                            guest_score = result_versus.result.split(':')[1] if result_versus.result.present?

                            home_rec = the_same_score_teams.where(team_id: home_team_id).first
                            guest_rec = the_same_score_teams.where(team_id: guest_team_id).first

                            if result_versus.result.present? && home_score > guest_score && home_rec.place.nil?
                                #puts '11111111111111111' +'place=' + place.to_s + 'home_rec_place = '+ home_rec.place.to_s
                                guest_rec.update_attribute(:place, place)
                                place+=1
                                home_rec.update_attribute(:place, place)
                                place+=1
                                break
                            elsif result_versus.result.present? && home_score < guest_score && guest_rec.place.nil?
                                #puts '2222222222222222'+'place=' + place.to_s + 'guest_rec_place = '+ guest_rec.place.to_s
                                home_rec.update_attribute(:place, place)
                                place+=1
                                guest_rec.update_attribute(:place, place)
                                place+=1
                                break
                            
                            elsif result.place.nil?
                                #puts '33333333333333'+'place=' + place.to_s
                                result.update_attribute(:place, place)
                                place+=1
                                # наибольшее число побед во всех встречах
                                # лучшая разница мячей во всех встречах
                                # наибольшее количество забитых мячей во всех встречах
                        
                            end
                        else
                                puts '4444444444444'+'place=' + place.to_s
                                result.update_attribute(:place, place)
                                place+=1
                                # наибольшее число побед во всех встречах
                                # лучшая разница мячей во всех встречах
                                # наибольшее количество забитых мячей во всех встречах
                        
                            
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
        end
        redirect_to team_position_table_path(params[:league_id])
    end
   
    private
    def check_admin
        redirect_to root_path unless current_user.present? && current_user.active_admin
    end
end
