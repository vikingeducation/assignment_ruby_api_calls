require 'figaro'
require 'httparty'

Figaro.application = Figaro::Application.new(
  environment: 'development',
  path: File.expand_path('../config/application.yml', __FILE__)
)
Figaro.load

class WeatherForecast

  def initialize

  end

end

t = WeatherForecast.new