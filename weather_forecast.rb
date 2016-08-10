require 'httparty'
require 'json'

class WeatherForecast
  include HTTParty

  base_uri "http://api.openweathermap.org"
  API_KEY = ENV["WEATHER_FORECAST_API_KEY"]

  def initialize location = "Nanjing, CN", num_days = 7
    validate_num_days!(num_days)

    @location = location
    @num_days  = num_days
  end

  def ex_temps
    response = send_request
    trim_response response
  end


  private
    def validate_num_days! num_days
      unless num_days.between? 1, 16
        raise "Invalid days input."
      end
    end

    def trim_response response
      results = response["list"]
      results.map do |weather|
        {
          :max => weather["temp"]["max"]
          :min => weather["temp"]["min"]
        }
      end
    end

    def send_request
      params = { query: {
        :APPID   => API_KEY,
        :q       => @location,
        :mode    => "json" }
      }
      self.class.get("/data/2.5/forecast/daily", params)
    end
end
