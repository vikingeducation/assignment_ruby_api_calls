require_relative 'env'
require 'httparty'
require 'json'
require 'pp'

class WeatherForecast



# days 1-10, location city ST or zipcode
  def initialize(location = '22180', days = 1)
    @days = days.to_s
    @location = location.to_s
    @base_uri = "http://api.apixu.com/v1/forecast.json?"
  end

  def build_uri
    uri = [@base_uri] << "key=#{API_KEY}" << "q=#{@location} " << "days=#{@days}"
    uri.join('&')
  end

  def send_request
    @request = HTTParty.new.get(build_uri)

  end



  def hi_temps
    # forecast.forecastday.day.maxtemp_f
    @request["forecast"]["forecastday"].map {|date|  date["day"]["maxtemp_f"]    }
  end

  def low_temps
    # forecast.forecastday.day.mintemp_f
    @request["forecast"]["forecastday"].map {|date|  date["day"]["mintemp_f"]    }
  end

  def today
    # current.temp_f
    #hi_
    #lo_
    current_spot = @request["forecast"]["forecastday"][0]["day"]
    @request["current"]["temp_f"]
    current_spot["maxtemp_f"]
    current_spot["mintemp_f"]
    current_spot["condition"]


  end

  def tomorrow
    current_spot = @request["forecast"]["forecastday"][1]["day"]
    current_spot["maxtemp_f"]
    current_spot["mintemp_f"]
    current_spot["condition"]
  end




end


w_api = WeatherForecast.new('bloomington in', 3)
w_api.send_request
p w_api.hi_temps

