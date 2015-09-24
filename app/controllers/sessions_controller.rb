class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.where(email: user_params[:email]).first
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      flash[:loggedIn] = "Successfully logged in. Greetings, #{@user.first_name}!"
      redirect_to "/"
    else
      flash[:notice] = "Oops! There was an issue with your log in credentials."
      redirect_to "/sessions/new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out."
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
