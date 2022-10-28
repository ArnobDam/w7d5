class SessionsController < ApplicationController

    before_action :require_logged_in, only: [:destroy]

    def new

    end
    
    def create
        @user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )
        if @user
            login!(@user)
        else
            flash.now[:errors] = ["Invalid username or password"]
            render :new
        end
    end

    def destroy
        logout!
        render :new
    end

end
