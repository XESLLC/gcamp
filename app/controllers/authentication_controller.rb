class AuthenticationController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if session[:return_to] && session[:return_to] != "/" 
        redirect_to session[:return_to], notice: "You have successfully signed in"
      else
       redirect_to projects_path, notice: "You have successfully signed in"
      end
    else
      redirect_to signin_path, alert: "Email / Password combination is invalid ", notice: "dummy"
    end
  end

  def destroy
    session.clear
    redirect_to root_path, notice: "You have successfully signed out"
    session.clear
    end

end
