class Api::V1::MeasuresController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    measures = Measure.incldues(:measurement).where(user_id: current_api_v1_user.id)
    render_success(measures)
  end

  def create
    new_measure = current_api_v1_user.measures.create!(measure_params)

    render_success(new_measure, 201)
  end

  def show
    @measure = Measure.find(params[:id])
    return render_error(['You do not have permission'], 403) unless @measure.user_id == current_api_v1_user.id

    render_success(@measure.to_json(include: [:measurements]), 200)
  end

  def new_measurement
    measure = Measure.find(params[:id])
    return render_error(['You do not have permission'], 403) unless measure.user_id == current_api_v1_user.id

    measure.measurements.create!(measurement_params)
    @measure = Measure.includes(:measurements).find(measure.id)
    render_success(@measure.to_json(include: [:measurements]), 201)
  end

  private

  def measure_params
    params.permit(:title)
  end

  def measurement_params
    params.permit(:value, :date)
  end
end
