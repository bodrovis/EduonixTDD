class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.present? && @user.authenticate(params[:password])
      flash[:success] = 'Welcome!'
      redirect_to root_path
    else
      flash.now[:danger] = 'Incorrect email and/or password!'
      render :new
    end
  end
end
