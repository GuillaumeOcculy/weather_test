class ForecastsController < ApplicationController
  before_action :require_user

  def new
    @forecast = Forecast.new
  end

  def create
    name = forecast_params[:city].strip.downcase
    date = forecast_params[:date] || Date.today

    res = GetOrCreateForecastService.call(name, date)

    if res.success?
      redirect_to res.forecast
    else
      @forecast = Forecast.new
      flash[:notice] = res.error_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @forecast = Forecast.find(params[:id])
  end

  private

  def forecast_params
    params.require(:forecast).permit(:city, :date)
  end
end
