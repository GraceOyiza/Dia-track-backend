class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_v1_user!

  def show
    user = User.includes(:readings, :measures).where(id: current_api_v1_user.id).first
    puts user, user.readings
    render_success(user)
  end
end
