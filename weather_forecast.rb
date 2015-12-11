require 'httparty'
require 'awesome_print'
require 'json'
require 'pry'
require 'envyable'

Envyable.load('env.yml')

class WeatherForecast
  BASE_URI = 'http://api.openweathermap.org/data/2.5/forecast?q='
  API_KEY = ENV['OPEN_WEATHER_API_KEY']

  def initialize(location = 'New Orleans', days = 5)
    location.gsub!(' ', '%20')
    @forecast = send_request(location, days)
  end

  private

  def send_request(location, days)
    uri = "#{BASE_URI}#{location},USA&cnt=#{days}&APPID=#{API_KEY}"

    response = HTTParty.get(uri)
    binding.pry

    response["list"]
  end
end

forecast = WeatherForecast.new