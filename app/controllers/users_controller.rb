class UsersController < ApplicationController
  before_action :authenticate_user!, :check_user
  
  def index
    
  end
  def check_user 
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to root_path
    end
  end


  def show
    @user = current_user
    @created_events = @user.events.where(administrator_id: @user.id)
  end
end
