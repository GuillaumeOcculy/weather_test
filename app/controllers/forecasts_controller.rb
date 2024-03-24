require "accu_weather_api"

class ForecastsController < ApplicationController
  before_action :require_user

  def new
    @forecast = Forecast.new
  end

  def create
    name = forecast_params[:city].strip.downcase
    res = GetOrCreateForecastService.call(name)

    if res.success?
      redirect_to res.forecast
    else
      flash[:notice] = res.error_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @forecast = Forecast.find(params[:id])
  end

  private

  def forecast_params
    params.require(:forecast).permit(:city)
  end
end
