class UserController < ApplicationController
    
    def login
        #before_action :authenticate_user!
        session[:login] = 1
        session[:cart] = nil
        flash[:notice] = "Successfully logged in."
        redirect_to :controller => :items
    end 
    
    def logout
        session[:login] = nil
        session[:cart] = nil
        flash[:notice] = "Successfully logged out."
        redirect_to :controller => :items
    end 
    
    def index
       @users  = User.all
    end    
    
    def show  
        @useruser.find(params[:id])
    end    
    
    def update
        @user = User.find(params[:id])
        if @user.update_attributes(secure_params)
            redirect_to root_path, :notice => 'no problem, job done'
        else 
            redirect_to root_path, :alert => 'something went wrong'
        end
    end
    
    private 
    def secure_params
        params.require(:user).permit(:role)
    end    

    
end
