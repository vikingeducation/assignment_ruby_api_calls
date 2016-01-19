require 'httparty'
require 'json'
require 'pp'

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
    @days = "cnt=#{days}"
    @daily = daily ? "/daily" : ""
    @location = location.is_a?(String) ? "q=#{location}" : "id=#{location}"
    @response = nil
    @api = "APPID=#{API_KEY}"
  end

  def send_request
    uri = BASE_URI + "#{@daily}?#{@location}&#{@days}&#{JSON_FORMAT}&#{@api}"
    @response = HTTParty.get(uri)
  end

  def parse_json
    response_body = JSON.parse(@response.body)
    forecast = response_body["list"]
    forecast.map do |element|
      {
        :day_id       =>    element["dt"]
        :temp         =>    element["temp"],
        :pressure     =>    element["pressure"],
        :humidity     =>    element["humidity"],
        :weather      =>    element["weather"],
        :speed        =>    element["speed"],
        :deg          =>    element["deg"],
        :clouds       =>    element["clouds"],
        :snow         =>    element["snow"]
      }
    end
  end

  def hi_temps
    
  end

  def lo_temps
  end

  def today
  end

  def tomorrow
  end

end

w_api = WeatherForecast.new("London,us",3,true)
w_api.send_request
w_api.parse_json
