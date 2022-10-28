class UsersController < ApplicationController
    before_action :require_logged_in, only: [:index, :show, :edit, :update]
    before_action :require_logged_out, only: [:new, :create]

    def index
        @users = User.all
    end

    def show
        @user = User.find_by(id: params[:id])
        # redirect_to user_url(@user)
        # render :show
    end

    def new

    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to user_url(@user)
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to new_user_url
            # render :new
        end
    end

    def update
        @user = User.find_by(id: params[:id])
        if @user.update(user_params)
            redirect_to user_url(@user)
        else
            render :edit
        end

    end

    def edit
        @user = User.find_by(id: params[:id])
        render :edit
    end


    private
    def user_params
        params.require(:user).permit(:username, :password)
    end
end
