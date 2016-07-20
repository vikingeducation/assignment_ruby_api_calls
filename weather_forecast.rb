require 'httparty'
require 'env'

class WeatherForecast 

  END_POINT = 'http://api.apixu.com/v1/'

  def initialize(options = {})
    @key = options[:key]

  end

end

