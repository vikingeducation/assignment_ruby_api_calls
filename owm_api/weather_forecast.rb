require 'httparty'
require 'pp'
require 'json'

require_relative 'example' # sets API key environmental variable
require_relative 'day' # stores information on a day based on JSON data from OWM

class WeatherForecast # using Open Weather Map

  def initialize location="San Francisco", days=1
    raise ArgumentError if days < 1 || days > 16

    @location = location.downcase
    @days = days
    @key = ENV["OWM_KEY"]

    request_url
    send_request
    parse_JSON
    get_days
  end

  def request_url
    location = @location.gsub(/\s+/, "+")
    @url = "http://api.openweathermap.org/data/2.5/forecast/daily?q="
    @url += "#{location}" # adds location
    @url += "&cnt=#{@days}" # adds day count
    @url += "&units=imperial" # sets imperial units
    @url += "&appid=#{@key}" # adds api key
  end

  def send_request
    @response = HTTParty.get(@url)
  end

  def parse_JSON
    @response_json = JSON.parse(@response.body)
  end

  def get_days
    days = @response_json["list"]
    days.each do |day|

    end
    pp @response_json["list"]
  end

end

t = WeatherForecast.new("san francisco", 3)
