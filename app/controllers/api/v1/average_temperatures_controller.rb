class Api::V1::AverageTemperaturesController < Api::V1::BaseController
  def show
    res = AverageTemperatureService.call(params[:cities])
    if res.success?
    render json: { average_temperature: res.average_temperature, unit: "C", cities: res.city_names }
    else
      render json: { error: res.error_messages }, status: :unprocessable_entity
    end
  end
end
