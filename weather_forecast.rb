require 'httparty'

class WeatherForecast

  BASE_URI = "http://api.openweathermap.org/data/2.5/forecast"
  API_KEY = ENV["OPEN_WEATHER_MAP_KEY"]
  JSON_FORMAT = "mode=json"

  def initialize(location="524901",days=5)
    if days == 5
      response = HTTParty.get(BASE_URI + "?id=#{location}&#{JSON_FORMAT}" )
    elsif days == 16
      response = HTTParty.get(BASE_URI + "daily?id=#{location}&#{JSON_FORMAT}")
    else
      raise ArgumentError, "Input days must either be 5 or 16!"
    end

  end

end
