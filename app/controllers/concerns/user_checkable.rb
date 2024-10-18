# app/controllers/concerns/user_checkable.rb
module UserCheckable
  extend ActiveSupport::Concern

  included do
    before_action :check_user!
  end

  private

  def check_user!
    redirect_to new_user_session_path unless current_user
  end
end
