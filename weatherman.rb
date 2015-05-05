require 'typhoeus'
require 'json'
require 'pry-byebug'
require 'pp'

class WeatherForecast

  attr_accessor :location, :num_days
  API_KEY = "27e1089ca0909572ccfe9e97a236f608"
  BASE_URI = "api.openweathermap.org/data/2.5/forecast/daily?q="
  VALID_FORMATS = [:json]
  MID_SANDWICH = "&mode=json&units=metric&cnt="

  def initialize(location = "Truro,UK", num_days = 5)
    @location = location
    @num_days = num_days
    validate_num_days!(num_days)
    validate_location!(location)
  end

  def hi_temps
    trim_and_request(@location, @num_days).each do |day|
      puts day["temp"]["max"]
    end
  end

  def low_temps
    trim_and_request(@location, @num_days).each do |day|
      puts day["temp"]["min"]
    end
  end

  def today
    today = trim_and_request(@location, @num_days)[0]
    puts "Today's forecast: \n humidity of #{today["humidity"]} %, with #{today["weather"][0]["description"]}, and wind at #{today["speed"]} kilometers an hour"
  end

  def tomorrow
    today = trim_and_request(@location, @num_days)[1]
    puts "Tomorrow's forecast: \n humidity of #{today["humidity"]} %, with #{today["weather"][0]["description"]}, and wind at #{today["speed"]} kilometers an hour"
  end

  #three more

  private

  def send_request(location, num_days)
    uri = [ BASE_URI, location, MID_SANDWICH, num_days ].join("")
    params = { "api-key" => API_KEY }

    request = Typhoeus::Request.new( uri, :method => :get, :params => params )

    request.run
  end

  def trim_and_request(location, num_days)
    response = send_request(location, num_days)
    return JSON.parse( response.response_body )["list"]
  end

  def validate_num_days!(num_days)
    unless num_days < 30
      raise "Invalid length"
    end
  end

  def validate_location!(location)
    true
  end

end

#USER INSTRUCTIONS HERE

# e.g. my_weather = WeatherForecast.new("Superior,MT,USA",12)
# my_weather.today
# my_weather.tomorrow
