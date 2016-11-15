class WeatherForecast
  include HTTParty

  BASE_URI = "api.openweathermap.org/data/2.5/forecast?q=" # {city name},{country code}
  def initialize(location = "Cupertino", num_days = 5, mode = "json")
    @location = location
    @num_days = num_days
    @http_client = HTTParty
    @mode = mode 
  end

  def get_forecast
    endpoint = "#{BASE_URI}#{@location}&mode=#{@mode}"
    @http_client.get(endpoint)
  end
end