
class WeatherForecast
  include HTTParty

  BASE_URI = "http://api.openweathermap.org/data/2.5/forecast" # {city name},{country code}
  API_KEY = ENV['WEATHER_KEY']
  def initialize(city_id_mappings, location = "Cupertino", num_days = 5)
    @location = location
    @num_days = num_days
    @http_client = HTTParty
    @mode = mode
    @city_id_mappings =
  end

  def get_forecast
    endpoint = "#{BASE_URI}?id=#{location_id}&appid=#{API_KEY}"
    @http_client.get(endpoint)
  end

  def location_id
    @city_id_mappings[@location]
  end

end
