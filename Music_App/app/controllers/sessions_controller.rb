class SessionsController < ApplicationController
    #before_action :require_logged_out, only: [:new, :create]

    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(
            params[:user][:email],
            params[:user][:password]
        )

        if @user
            login(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = ['Incorrect username or password']
            render :new #this is coming from new session page
        end
    end

    def destroy
        logout 
        redirect_to new_session_url
    end

    
end
