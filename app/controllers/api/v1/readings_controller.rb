class Api::V1::ReadingsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_reading, except: [:index, :create]

  def index
    render_success(current_api_v1_user.readings)
  end

  def create
    new_reading = current_api_v1_user.readings.create!(reading_params)

    render_success(new_reading, 201)
  end

  def update
    @reading.update(reading_params)

    return render_error(['Server Error something went wrong'], 500) unless @reading.save

    render_success(@reading, 200)
  end

  def destroy
    return render_error(['Server Error something went wrong'], 500) unless @reading.destroy

    render_success('Reading deleted successfully', 204)
  end

  private

  def reading_params
    params.permit(:fasting, :after_meal, :bp, :date)
  end

  def set_reading
    @reading = current_api_v1_user.readings.find(params[:id])
  end
end
