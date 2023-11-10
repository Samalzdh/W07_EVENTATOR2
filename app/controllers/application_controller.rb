class ApplicationController < ActionController::Base
  layout :set_layout

  private

  def set_layout 
    if current_user.role&.admin?
      # equivalent a if current_user && current_user.admin == true 
      "admin"
    else
      "application"
    end
end