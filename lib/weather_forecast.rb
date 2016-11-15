
class WeatherForecast
  include HTTParty

  BASE_URI = "http://api.openweathermap.org/data/2.5/forecast/daily" 

  API_KEY = ENV['WEATHER_KEY']

  def initialize(args = {})
    @location         = args.fetch(:location, 'cupertino')
    @num_days         = args.fetch(:days, 5)
    @http_client      = args.fetch(:http_client, HTTParty)
    @city_id_mappings = args.fetch(:city_id_mappings, nil)
    @units            = args.fetch(:units, "imperial")
  end

  def get_forecast
    http_client.get(BASE_URI, query: { q: location, appid: API_KEY, units: units })
  end

  def high_temps
  end

  def low_temps
  end

  private
    attr_reader :city_id_mappings, :http_client, :location, :units
end

