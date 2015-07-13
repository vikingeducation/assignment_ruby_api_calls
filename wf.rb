require 'HTTParty'
require 'json'

require 'pry-byebug'
require 'pp'



class WeatherForecast

  BASE_URI = "http://api.openweathermap.org/data/2.5/"

  API_KEY = ENV["API_KEY"]

  #number of days = 0 : current weather = weather?
  #number of days = 1-5 : 5 day forecast = forecast?
  #number of days 5- 16 : 16 day forecast = forecast/daily?
  #number of days beyond 16 raises error

  def initialize(zipcode = 93546, num_of_days = 3)
    # validate_zip!(zipcode)
    # validate_numofdays!(num_of_days)

    @zipcode = zipcode
    @num_of_days = num_of_days
    @forecast_type = convert_days_to_forecast_type
    send_request
  end

  def convert_days_to_forecast_type
    if @num_of_days == 0
      return "weather?"
    elsif (1..5).include?(@num_of_days)
      return "forecast?"
    elsif (6..16).include?(@num_of_days)
      return "forecast/daily?"
    end
  end

  def zipcode_uri
    string =""
    string << "zip=#{@zipcode},us"
  end


  def send_request
    uri = [BASE_URI, @forecast_type, zipcode_uri].join("")
    puts uri.inspect

    params = { "api-key" => API_KEY }

    request = HTTParty.get(uri, params)
    request.body

  end

  

end