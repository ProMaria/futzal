class TableController < ApplicationController
    before_action :set_initial
    def team_position       
        @table_results = TableResult.where(league_id: params[:id]).order(:place)
        @table_final = Schedule.joins(:tour).where("tours.name ~ 'финал'") if params[:id]=='1' 
        if @table_final.present?
            #Первый полуфинал
            @teams=TableResult.where(league_id: 1).order(:place).first(4)
            @results_first_semifinal = Schedule.joins(:tour).where("tours.name ~ 'олуфинал'").where('schedules.home_team_id =? or schedules.home_team_id =? ', @teams[0].team.id,@teams[3].team.id  )            
            @results_first_semi='Матч не сыгран'
            @winner_first_semifinal='Победитель пары 1-4'
            @lost_first_semifinal = 'Проигравший пары 1-4'
            if @results_first_semifinal.present? &&  @results_first_semifinal.first.result.present?  
                @score_first_semifinal = @results_first_semifinal.first.result
                @results_first_semi=@results_first_semifinal.first.result
                if @score_first_semifinal.count(':')>1
                    @score_first_semifinal = @score_first_semifinal[@score_first_semifinal.index('(')+1,@score_first_semifinal.index(')')-1].delete('.').delete(' ').delete('А-Я а-я').delete('(').delete(')')
                end

                index_semicolon_first_semifinal = @score_first_semifinal.index(':')
                @first_result_first_semifinal = @score_first_semifinal[0, index_semicolon_first_semifinal].to_i
                @second_result_first_semifinal = @score_first_semifinal[index_semicolon_first_semifinal+1, @score_first_semifinal.length].to_i 
                @winner_first_semifinal = @first_result_first_semifinal>@second_result_first_semifinal ? @results_first_semifinal.first.home_team.name : @results_first_semifinal.first.guest_team.name   
                @lost_first_semifinal = @first_result_first_semifinal<@second_result_first_semifinal ? @results_first_semifinal.first.home_team.name : @results_first_semifinal.first.guest_team.name   
            end
            #Второй полуфинал
            @results_second_semifinal = Schedule.joins(:tour).where("tours.name ~ 'олуфинал'").where('schedules.home_team_id =? or schedules.home_team_id =? ', @teams[1].team.id,@teams[2].team.id  )            
            @results_second_semi='Матч не сыгран'
            @winner_second_semifinal='Победитель пары 2-3'
            @lost_second_semifinal = 'Проигравший пары 2-3'
            if @results_second_semifinal.present? &&  @results_second_semifinal.first.result.present?  
                @score_second_semifinal = @results_second_semifinal.first.result
                @results_second_semi=@results_second_semifinal.first.result
                if @score_second_semifinal.count(':')>1
                    @score_second_semifinal = @score_second_semifinal[@score_second_semifinal.index('(')+1,@score_second_semifinal.index(')')-1].delete('.').delete(' ').delete('А-Я а-я').delete('(').delete(')')
                end

                index_semicolon_second_semifinal = @score_second_semifinal.index(':')
                @first_result_second_semifinal = @score_second_semifinal[0, index_semicolon_second_semifinal].to_i
                @second_result_second_semifinal = @score_second_semifinal[index_semicolon_second_semifinal+1, @score_second_semifinal.length].to_i 
                @winner_second_semifinal = @first_result_second_semifinal>@second_result_second_semifinal ? @results_second_semifinal.first.home_team.name : @results_second_semifinal.first.guest_team.name   
                @lost_second_semifinal = @first_result_second_semifinal<@second_result_second_semifinal ? @results_second_semifinal.first.home_team.name : @results_second_semifinal.first.guest_team.name   
            end

            #Третье место
            if Team.where(name: @lost_first_semifinal).present? && Team.where(name: @lost_second_semifinal).present?
                results_third_place = Schedule.joins(:tour).where("tours.name ~ '3 место'").where('schedules.home_team_id =? and schedules.guest_team_id =? ', Team.find_by_name(@lost_first_semifinal).id, Team.find_by_name(@lost_second_semifinal).id )            
                @results_third_place=results_third_place.present? ? results_third_place.first.result : 'матч не сыгран'
                @date_third_place=results_third_place.present? ? results_third_place.first.timestamp.strftime('%d.%m.%Y') : ''
            end

            #Финал
            if Team.where(name: @winner_first_semifinal).present? && Team.where(name: @winner_second_semifinal).present?
                results_first_place = Schedule.joins(:tour).where("tours.name ~ 'Финал'").where('schedules.home_team_id =? and schedules.guest_team_id =? ', Team.find_by_name(@winner_first_semifinal).id, Team.find_by_name(@winner_second_semifinal).id )            
                @results_first_place=results_first_place.order(:timestamp)
            end

                
        end
    end   
    
    def match_result
        @teams = TableResult.where(league_id: params[:id]).order(:place).pluck(:team_id)      
    end
    def goal_leader        
        @leaders = GoalLeader.joins(:team).where('teams.league_id=?', params[:id]).order('goal_leaders.goal desc')
    end
    
    def summary
        @teams = League.find(params[:id]).teams.pluck(:id)
        summary = Schedule.finished.where(guest_team_id: @teams)
        @tours = Tour.where(id: summary.pluck(:tour_id).uniq).order(created_at: :desc)
    end
   private
    def set_initial
      @league_name = League.find(params[:id]).name
      @league = League.order(id: :desc)
    end
end
