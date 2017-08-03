class SessionsController < ApplicationController
  before_action :require_no_authentication!, except: [:destroy]
  before_action :require_authentication!, only: [:destroy]

  def destroy
    cookies.signed[:user_id] = nil
    flash[:success] = 'See you later!'
    redirect_to new_sessions_path
  end

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.present? && @user.authenticate(params[:password])
      cookies.signed[:user_id] = @user.id
      flash[:success] = 'Welcome!'
      redirect_to root_path
    else
      flash.now[:danger] = 'Incorrect email and/or password!'
      render :new
    end
  end
end
