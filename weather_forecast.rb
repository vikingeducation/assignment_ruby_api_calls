require 'httparty'
require 'pp'
require 'pry'

class WeatherForecast

  attr_reader :location, :days, :response

  BASE_URI = 'http://api.apixu.com/v1/forecast.json'

  def initialize(location = "San Francisco", days = 7)
    @location = location
    @days = days
    @response = get_response
  end

  def get_response
    puts ENV['WEATHER_KEY']
    end_point = BASE_URI + "?key=#{ENV['WEATHER_KEY']}&q=#{location}&days=#{days}"
    response = HTTParty.get(end_point)
    binding.pry

    response.parsed_response
  end

  def hi_temps
    # response['forecast']['forecastday'].each do |day|

    #    day['date']['maxtemp_f']
    response['forecast']['forecastday'].each_with_object({}) do  |day, object|
      object[day['date']] =
      day['day']['maxtemp_c']

    end


    # end
  end

  def lo_temps


  end

  def today

  end

  def tomorrow

  end

end


# http://api.apixu.com/v1/current.json?key=<YOUR_API_KEY>&q=San Francisco&days=7
# WeatherForecast.new.get_response

puts WeatherForecast.new.hi_temps
# puts WeatherForecast.new.get_response.body.class

# File.open("results.json", "w+") do |f|
#   f.write(JSON.parse(WeatherForecast.new.get_response.to_s))
# end
