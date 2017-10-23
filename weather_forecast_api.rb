require 'dotenv/load'

require 'httparty'
require 'pp'
require "awesome_print"
require 'json'

class WeatherForecast
  attr_accessor :raw_response
  def initialize(location: 70115, days: 1)
    @location = location
    @days = days
    @raw_response = {}
  end

  API_KEY = ENV['API_KEY']

  BASE_URI = "http://api.openweathermap.org"

  # url = "api.openweathermap.org/data/2.5/forecast/daily?q={city name},{country code}&cnt={cnt}"


  def send_request
    url = "#{BASE_URI}/data/2.5/forecast?zip=#{@location}&APPID=#{API_KEY}"
    response = HTTParty.get(url)
    save_response(response)
  end

  def save_response(response)
    File.open("data/temp.json","w") do |f|
      f.write(response)
    end
  end

  def high_temps
    # should be a collection of the high temperatures you get back, organized by date
    retrieve_response

    puts "Weather for #{@raw_response['city']['name']}"
    @raw_response['list'].each do |date|

      max = date['main']['temp_max']
      # p convert_to_fahrenheit(max)

      p "#{date['dt_txt']}: #{convert_to_fahrenheit(max)}"
    end
  end



  private

  def retrieve_response
    @raw_response = JSON.parse(File.read("data/temp.json"))
  end

  def convert_to_fahrenheit(k)
    f = (1.8 * (k - 273)) + 32
    f.round(1)
  end
end

forecast = WeatherForecast.new(location: 15601, days: 5)
# forecast.retrieve_response
# pp forecast.raw_response
forecast.high_temps