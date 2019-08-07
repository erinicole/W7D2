class UsersController < ApplicationController
    #before_action :require_logged_in, except: [:create, :new]

    def index
        @users = User.all

        
    end

    def show
        @user = User.find_by(id: params[:id])
        #rails will automatically render shows view part of rails magic
        render :show
    end
    
    def create
        @user = User.new(user_params)
        if @user.save!
            login(@user)
            redirect_to user_url(@user)
        else
            flash[:error] = @user.errors.full_messages
            render :new
        end
    end

    def new #this just renders a form
        user = User.new 
        render :new #rails will do this, so you don't need it.
    end

    def edit
    end


    private

    def user_params
        params.require(:user).permit(:email, :password)
    end


end
