
require 'pry'
require 'uri'
require 'httparty'
# http://api.apixu.com/v1/forecast.json?key=fe0fa84dda2a49f28ce160812162007&q=Paris
class WeatherForecast
  BASE_URL = 'http://api.apixu.com/v1/'
  API_KEY = ENV['APIX_API_KEY']

  def initialize(loc, days=1)
    validate_location(loc)
    validate_num_of_days(days)

    @loc = loc
    @days = days

  end

  def build_url
    type = @days > 1 ? "forecast" : "current"
    "{BASE_URL}/{type}.json?key={API_KEY}&q={@loc}&days={@days}"
  end

  def send_request

  end

  def validate_location(loc)

  end

  def validate_num_of_days(num)
    (0..10) === num
  end
end
