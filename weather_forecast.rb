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
    @forecast = nil
  end

  def send_request
    uri = BASE_URI + "#{@daily}?#{@location}&#{@days}&#{JSON_FORMAT}&#{@api}"
    @response = HTTParty.get(uri)
  end

  def parse_json
    response_body = JSON.parse(@response.body)
    @forecast = response_body["list"]
    @forecast.map do |element|
      {
        :day_id       =>    element["dt"],
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
    hi_temps = []
    puts "\nHigh Temperature Forecast:\n"
    @forecast.each do |element|
      puts "Day #{element["dt"]} -> #{element["temp"]["max"]}"
      hi_temps << [ element["dt"],element["temp"]["max"]]
    end
    hi_temps
  end

  def lo_temps
    lo_temps = []
    puts "\nLow Temperature Forecast:\n"
    @forecast.each do |element|
      puts "Day #{element["dt"]} -> #{element["temp"]["min"]}"
      lo_temps << [ element["dt"],element["temp"]["min"]]
    end
    lo_temps
  end

  def avg_temps
    avg = []
    puts "\nAverage Temperature Forecast:\n"
    @forecast.each do |element|
      puts "Day #{element["dt"]} -> #{element["temp"]["day"]}"
      avg << [ element["dt"],element["temp"]["day"]]
    end
    avg
  end

  def today
    puts "\nToday's forecast\n"
    today = @forecast[0]
    today.each do |key,value|
      puts "#{key} -> #{value}"
    end
    today
  end

  def tomorrow
    puts "\nTomorrow's forecast\n"
    tomorrow = @forecast[1]
    tomorrow.each do |key,value|
      puts "#{key} -> #{value}"
    end
    tomorrow
  end

  def weather_descriptions
    desc = []
    puts "\nWeather Description Forecast:\n"
    @forecast.each do |element|
      puts "Day #{element["dt"]} -> #{element["weather"][0]["description"]}"
      desc << [ element["dt"],element["weather"][0]["description"]]
    end
    desc
  end

  def wind_speeds
    speed = []
    puts "\nWind Speed Forecast:\n"
    @forecast.each do |element|
      puts "Day #{element["dt"]} -> #{element["speed"]}"
      speed << [ element["dt"],element["speed"]]
    end
    speed
  end

end

w_api = WeatherForecast.new("London,us",10,true)
w_api.send_request
w_api.parse_json
w_api.hi_temps
w_api.lo_temps
w_api.avg_temps
w_api.today
w_api.tomorrow
w_api.weather_descriptions
w_api.wind_speeds
