require 'httparty'

class WeatherForecast

  END_POINT = 'http://api.apixu.com/v1/forecast.json'

  def initialize(location = "San Francisco", days = 7)
    @location = location
    @days = days
  end

  def get


  end



end