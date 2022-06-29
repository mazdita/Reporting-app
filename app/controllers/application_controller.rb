class ApplicationController < ActionController::Base
    before_action :is_signed_in, except: :new
    def is_signed_in
        redirect_to new_admin_session_path unless current_admin
    end
end
