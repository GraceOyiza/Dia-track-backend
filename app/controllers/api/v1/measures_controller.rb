class Api::V1::MeasuresController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_reading, except: %i[index create]

  def index
    render_success(current_api_v1_user.measures)
  end

  def create
    new_measure = current_api_v1_user.measures.create!(measure_params)

    render_success(new_measure, 201)
  end

  def measure_params
    params.permit(:title)
  end
end
