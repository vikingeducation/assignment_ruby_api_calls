
require 'pry'
require 'uri'
require 'httparty'

class WeatherForecast
  BASE_URL = 'http://api.apixu.com/v1/'
  API_KEY = ENV['APIX_API_KEY']

  def initialize(loc, days)
    valid_location(loc)
    valid_num_of_days(days)
  end



  def valid_location(loc)
    
  end

  def valid_num_of_days(num)
    (0..10) === num
  end
end
