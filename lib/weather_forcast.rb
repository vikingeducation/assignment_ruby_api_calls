require "httparty"
require "figaro"
require "pry"


class WeatherForcast
  include HTTParty

  attr_reader :zip, :location

  END_POINT = "http://api.openweathermap.org/data/2.5/forecast?"
  API_KEY = Figaro.env.weather_api

  def initialize(zip = '33603', length = 3)
    @zip = zip
    @length = length
  end

  def get
    sleep(0.5)
    url = build_url(zip)
    # binding.pry
    response = HTTParty.get(url)
    p response
    # response = JSON.parse(response.body)
    # trim_or_full(response, trim)
  end


  private

  def build_url(zip)
    END_POINT + build_query_string(zip)
  end

  def build_query_string(zip)
    "zip=#{zip}&APPID=#{API_KEY}"
  end

end

#api.openweathermap.org/data/2.5/weather?zip=33603,us&APPID=1fd1b847e28c0ed4b796b1ba04ece9cc
tampa = WeatherForcast.new('33603')
tampa.get