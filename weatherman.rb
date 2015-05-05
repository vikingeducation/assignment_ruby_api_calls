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

  def initialize(location, num_days)
    @location = location
    @num_days = num_days
    validate_num_days!(num_days)
    validate_location!(location)
    send_request(@location, @num_days)
  end

  def hi_temps
  end

  def low_temps
  end

  def today
  end

  def tomorrow
  end

  #three more


  private

  def send_request(location, num_days)
    return unless location && num_days

    uri = [ BASE_URI, location, MID_SANDWICH, num_days ].join("")
    binding.pry
    params = 0

    request = 0

    # request.run
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

hi = WeatherForecast.new("Truro,UK",5)