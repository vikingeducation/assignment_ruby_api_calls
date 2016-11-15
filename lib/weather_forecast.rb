
class WeatherForecast
  include HTTParty

  BASE_URI = "http://api.openweathermap.org/data/2.5/forecast" # {city name},{country code}
  API_KEY = ENV['WEATHER_KEY']

  def initialize(args = {})
    @location         = args.fetch(:location, 'cupertino')
    @num_days         = args.fetch(:days, 5)
    @http_client      = args.fetch(:http_client, HTTParty)
    @city_id_mappings = args.fetch(:city_id_mappings, nil)
  end

  def get_forecast
    http_client.get(BASE_URI, query: { id: 524901, appid: API_KEY })
    #http_client.get(BASE_URI, query: { id: location_id, appid: API_KEY })
  end

  def location_id
    city_id_mappings[location]
  end

  private
    attr_reader :city_id_mappings, :http_client, :location
end

# ------------------------------------------------

class JSONParser

  def parse(json)
    JSON.parse('city_list.json')
  end

end

city_id_file_path = File.expand_path('city_list.json', File.dirname(__FILE__))

city_id_json = File.open(city_id_file_path).read

p city_id_json

#p JSONParser.new.parse(city_id_json)
