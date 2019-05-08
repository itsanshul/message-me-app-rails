class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully Logged In"
      redirect_to root_path
    else
      flash.now[:error] = "Something wrong with the details"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out Successfully"
    redirect_to root_path
  end

  private
  def require_same_user
    if current_user!= user.id
      flash[:error] = "You cannot perform this action"
      redirect_to root_path
    end
  end
  def logged_in_redirect
    if logged_in?
      flash[:error] = "You are already logged In."
      redirect_to root_path
    end
  end
end