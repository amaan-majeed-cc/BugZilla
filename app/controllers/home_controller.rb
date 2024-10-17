class HomeController < ApplicationController
  def index
    @user = current_user
    if @user
      @tickets_assigned = @user.tickets_assigned
    end
  end
end
