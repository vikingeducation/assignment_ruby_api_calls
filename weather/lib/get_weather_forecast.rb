require "httparty"
require "figaro"
require "pry"


class GetWeatherForecast
  include HTTParty

  attr_reader :zip, :location

  END_POINT = "http://api.openweathermap.org/data/2.5/forecast?"
  API_KEY = Figaro.env.weather_api

  def initialize(zip = '33603', length = 3, key)
    @zip = zip
    @length = length
    @key = key
  end

  def get
    sleep(0.5)
    url = build_url(zip, @key)
    response = HTTParty.get(url)

    # response = JSON.parse(response.body)
    # trim_or_full(response, trim)
  end



  private

  def build_url(zip, key)
    END_POINT + build_query_string(zip, key)
  end

  def build_query_string(zip, key)
    "zip=#{zip}&units=imperial&APPID=#{key}"
  end

end