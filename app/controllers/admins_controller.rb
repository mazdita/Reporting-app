class AdminsController < ApplicationController
    def index
        @admin = current_admin
    end

    def update
        @admin = current_admin
        if @admin.update(admin_params)
            redirect_to root_path
        else
            redirect_back(fallback_location: root_path)
            puts @admin.errors.full_messages
        end
    end

    private

    def admin_params
        params.require(:admin).permit(:email, :password, :password_confirmation, :current_password, :token)
    end

    def show
        @comments = Comment.where(admin_id: @admin)
    end
end
