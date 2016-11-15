class WeatherForecast
  include HTTParty

  def initialize(location = "Cupertino", num_days = 5)
    @location = location
    @num_days = num_days
  end

  def get_forecast

  end
end