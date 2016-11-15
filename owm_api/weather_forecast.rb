require 'figaro'
require 'httparty'
require 'pp'

Figaro.application = Figaro::Application.new(
  environment: 'development',
  path: File.expand_path('../config/application.yml', __FILE__)
)
Figaro.load

class WeatherForecast

  def initialize location="San Francisco", days=1
    raise ArgumentError if days < 1 || days > 16
    @location = location
    @days = days

    request_url
    puts @url
    send_request
  end

  def request_url
    location = @location.gsub(/\s+/, "+")
    @url = "http://api.openweathermap.org/data/2.5/forecast/daily?q="
    @url += "#{location}"
    @url += "&cnt=#{@days}"
  end

  def send_request
    response = HTTParty.get(@url)
    pp response
  end

end

t = WeatherForecast.new
