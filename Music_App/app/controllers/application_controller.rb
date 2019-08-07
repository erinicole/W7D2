class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!current_user #this makes it true or false if it is nil or current
    end

    def login(user)
        #somthing to do with user being logged in and their browser session token matching
        @current_user = user 
        session[:session_token] = user.reset_session_token!  
    end

    def logout
        if logged_in?
            current_user.reset_session_token!
        end
        session[:session_token] = nil
    end

    def require_logged_in
        redirect_to new_session_url unless logged_in?

    end

    def require_logged_out
        redirect_to users_url if logged_in? 
    end
end
