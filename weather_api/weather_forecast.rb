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
    @request = HTTParty.get(build_uri)
  end

  def location
    loc = @request["location"]
    city = loc["name"]
    state = loc["region"]
    [city, state]
  end

  def days_arr
    @request["forecast"]["forecastday"]
  end

  def hi_temps
    days_arr.map {|date|  date["day"]["maxtemp_f"]    }
  end

  def low_temps
    days_arr.map {|date|  date["day"]["mintemp_f"]    }
  end

  def today_precip_chance
    days_arr[0]["hour"].map {|hour| hour["will_it_rain"]}
  end

  def today
    current_spot = days_arr[0]["day"]
    current_temp = @request["current"]["temp_f"]
    max = current_spot["maxtemp_f"]
    min = current_spot["mintemp_f"]
    condition = current_spot["condition"]["text"]
    "Right now it is #{current_temp} and #{condition}, with a high of #{max} and low of #{min}."
  end

  def tomorrow
    current_spot = days_arr[1]["day"]
    max = current_spot["maxtemp_f"]
    min = current_spot["mintemp_f"]
    condition = current_spot["condition"]["text"]
    "Tomorrow will be #{condition} with a high of #{max} and a low of #{min}"
  end
end


w_api = WeatherForecast.new('bloomington in', 3)
w_api.send_request
p w_api.hi_temps
p w_api.today
p w_api.tomorrow
p w_api.today_precip_chance
