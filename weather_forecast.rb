require 'httparty'
require 'pp'
require 'pry'

class WeatherForecast

  attr_reader :location, :days, :response, :temp_to_string

  BASE_URI = 'http://api.apixu.com/v1/forecast.json'

  def initialize(location = "San Francisco", days = 7)
    @location = location
    @days = days
    @response = get_response
    @temp_to_string
  end

  def get_response
    puts ENV['WEATHER_KEY']
    end_point = BASE_URI + "?key=#{ENV['WEATHER_KEY']}&q=#{location}&days=#{days}"
    response = HTTParty.get(end_point)

    response.parsed_response
  end

  def hi_temps
    # response['forecast']['forecastday'].each do |day|

    #    day['date']['maxtemp_f']
    response['forecast']['forecastday'].each_with_object({}) do  |day, object|
      object[day['date']] = day['day']['maxtemp_f']

    end


    # end
  end

  def lo_temps
    response['forecast']['forecastday'].each_with_object({}) do  |day, object|
      object[day['date']] = day['day']['mintemp_f']
    
    end

  end

  def today
    pp response['forecast']['forecastday'][0]['day']
  end

  def tomorrow

  end

  def set_temp_string
    temp_strings = {
      "maxtemp_f" => "Max Temperature in Fahrenheit",
      "mintemp_f" => "Min Temperature in Fahrenheit",
      "avgtemp_f" => "Average Temp in Fahrenheit"
                    }

  end

end


# http://api.apixu.com/v1/current.json?key=<YOUR_API_KEY>&q=San Francisco&days=7
# WeatherForecast.new.get_response

puts WeatherForecast.new.today
# puts WeatherForecast.new.get_response.body.class

# File.open("results.json", "w+") do |f|
#   f.write(JSON.parse(WeatherForecast.new.get_response.to_s))
# end
