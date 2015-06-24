require 'json'
require 'httparty'
require 'pp'

class WeatherForecast

  include HTTParty

  base_uri "http://api.openweathermap.org"
  API_KEY = ENV["OPENWEATHERMAP_API_KEY"]

  def initialize(location = "Boston", number_of_days = 7)
    @options = { query: {q: location, mode: "json", units: "imperial", cnt: number_of_days, appid: API_KEY} }
    fetch_data
  end


  def hi_temps

  end


  def lo_temps

  end


  def today

  end


  def tomorrow

  end


  private

  def fetch_data
    @response = self.class.get('/data/2.5/forecast/daily', @options)
  end


end