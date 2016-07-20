require 'httparty'
require 'pp'

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
    response.parsed_response
  end

  def hi_temps
    response["maxtemp_f"]
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

