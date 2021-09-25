class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_v1_user!

  def show
    user = User.includes(:readings).find(current_api_v1_user.id)
    render_success(user)
  end
end
