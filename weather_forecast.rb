require 'httparty' 
require 'json'
require 'pp'
require 'envyable'

Envyable.load('config/env.yml')

class WeatherForecast

  BASE_URI = "http://api.openweathermap.org/data/2.5/forecast/daily"
  API_KEY = ENV["owm_key"]

  def initialize(location = "Charlotte,us" , days = 7)
    @location = location
    @days = days
  end
   
end

