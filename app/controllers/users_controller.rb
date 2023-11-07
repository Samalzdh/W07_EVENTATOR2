class UsersController < ApplicationController
  before_action :authenticate_user!, :check_user
  def index
    
  end
  def check_user 
    @user = User.find(id: params[:id])
    if current_user.id != @user.id
      redirect_to root_path
    end
  end
  def show
    @user = current_user
  end
end
