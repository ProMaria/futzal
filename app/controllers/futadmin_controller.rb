class FutadminController < ApplicationController
    before_action :check_admin
    def check_admin
        redirect_to root_path unless current_user.present? && current_user.active_admin
    end
end
