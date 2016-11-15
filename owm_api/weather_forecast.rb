require 'figaro'
require 'httparty'

class WeatherForecast

  def initialize
    p ENV["OWM_KEY"]
  end

end

t = WeatherForecast.new