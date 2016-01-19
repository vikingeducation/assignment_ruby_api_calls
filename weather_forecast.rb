require 'httparty'

class WeatherForecast

  BASE_URI = "http://api.openweathermap.org/data/2.5/forecast"
  API_KEY = ENV["OPEN_WEATHER_MAP_KEY"]
  JSON_FORMAT = "mode=json"

  def initialize(location="London,us",days=5, daily=true)

    raise ArgumentError if !days.is_a?(Integer) && days > 0
    raise ArgumentError if !location.is_a?(Fixnum) && !location.is_a?(String)

    #validate_time_period!(time_period)
    #validate_format!(response_format)
    @location = location
    @days = days
    @daily_str = daily ? "/daily" : ""
    @location = location.is_a?(String) ? "q=#{location}" : "id=#{location}"
    @response = nil
    @api_str = "APPID=#{API_KEY}"
  end

  def get_base_uri
    uri = BASE_URI + "#{@daily_str}?#{@location}&#{JSON_FORMAT}&#{@api_str}"
    puts "The URI is #{uri}"
    @response = HTTParty.get(uri)
  end

  def trim_response
    response_body = JSON.parse(@response.body)
  end

end

w_api = WeatherForecast.new("London,us",3,true)
w_api.get_base_uri
p w_api.trim_response