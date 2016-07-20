require 'weather_forecast'

class WeatherUI

  def initialize(location = "63376" , num_days = "1")
    @params = { q: location, days: num_days, key: my_key }
    # submit_request(params)
  end

  def submit_request
    WeatherForecast.new(@params)
  end

end
