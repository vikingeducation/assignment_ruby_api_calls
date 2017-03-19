require "httparty"
require "json"

class WeatherForecast
  include HTTParty
  attr_accessor :location, :raw_response

  BASE_URI = "http://api.openweathermap.org/data/2.5"
  API_KEY = ENV["API_KEY"]

  def initialize(location="Mountain View, US")
    response = send_request(location)
    check_response_ok!(response)
    @location = location
    @raw_response = response
  end

  def check_response_ok!(response)
    unless response["cod"] == 200
      raise "Response Error: #{response}"
    end
  end

  def valid_location?(location)
    location.split(",").count == 2
  end

  def send_request(location)
    uri = "#{BASE_URI}/weather"
    options = {query: {q: location, APPID: API_KEY}}
    self.class.get(uri, options)
  end

  def hi_temp
    raw_response["main"]["temp_max"]
  end

  def lo_temp
    raw_response["main"]["temp_min"]
  end

  def current_temp
    raw_response["main"]["temp"]
  end

  def weather
    raw_response["weather"].first["description"]
  end

  def humidity
    raw_response["main"]["humidity"]
  end

  def today
    {
      place: location,
      temp: current_temp,
      max_temp: hi_temp,
      min_temp: lo_temp,
      weather: weather,
      humidity: humidity
    }
  end

end

if __FILE__ == $0
  puts "Where do you want to get the forest for?"
  puts "Insert the location in the following format: Mountain View, US"
  print "> "
  location = gets.strip
  wf = WeatherForecast.new(location)
  puts "\nForecast for today:"
  puts wf.today
  puts
end
