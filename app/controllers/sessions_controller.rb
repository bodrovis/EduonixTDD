class SessionsController < ApplicationController
  before_action :require_no_authentication!

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.present? && @user.authenticate(params[:password])
      flash[:success] = 'Welcome!'
      cookies.signed[:user_id] = @user.id
      redirect_to root_path
    else
      flash.now[:danger] = 'Incorrect email and/or password!'
      render :new
    end
  end
end
