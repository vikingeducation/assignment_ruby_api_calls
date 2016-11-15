require 'httparty'
require 'pp'
require 'json'

require_relative 'example' # sets API key environmental variable
require_relative 'day' # stores information on a day based on JSON data from OWM
require_relative 'render' #outputs to CLI

class WeatherForecast # using Open Weather Map

  def initialize location="San Francisco", day_count=1
    raise ArgumentError if day_count < 1 || day_count > 16

    @location = location.downcase
    @day_count = day_count
    @key = ENV["OWM_KEY"]
    @all_days = []

    request_url
    send_request
    parse_JSON
    get_days
    render
  end

  def request_url # could be cleaned up by using parameters in HTTParty.get
    location = @location.gsub(/\s+/, "+")
    @url = "http://api.openweathermap.org/data/2.5/forecast/daily?q="
    @url += "#{location}" # adds location
    @url += "&cnt=#{@day_count}" # adds day count
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
    days_json = @response_json["list"]
    days_json.each do |day_json|
      @all_days << Day.new(day_json)
    end
  end

  def render
    puts "Press 1 for high temperatures"
    puts "Press 2 for low temperatures"
    puts "Press 3 for todays's temperature"
    puts "Press 4 for tomorrow's temperature"
    
    response = gets.chomp.to_i
    case response
    when 1
      Render.display_highs(@all_days)
    when 2
      Render.display_lows(@all_days)
    when 3
      Render.display_day(@all_days[0])
    when 4
      Render.display_day(@all_days[1])
    else
      "Enter a valid number!"
    end
  end

end

t = WeatherForecast.new("san francisco", 16)
