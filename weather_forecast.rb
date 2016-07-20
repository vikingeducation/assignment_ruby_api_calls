require 'pry'
require 'uri'
require 'httparty'
require 'prettyprint'
# http://api.apixu.com/v1/forecast.json?key=fe0fa84dda2a49f28ce160812162007&q=Paris
class WeatherForecast
  BASE_URL = 'http://api.apixu.com/v1'
  API_KEY = ENV['APIX_API_KEY']

  def initialize(loc, days=1)
    validate_location(loc)
    validate_num_of_days(days)
    @loc = loc
    @days = days
  end

  def get
    response = HTTParty.get(build_url).body
    hi_temps = get_hi_temps(response)
    low_temps = get_low_temps(response)
    today = get_today
    tomorrow = get_tomorrow
    precipitation = get_precip(response)
  end

  private
  def build_url
    loc = URI.encode(@loc)
    type = @days > 1 ? "forecast" : "current"
    "#{BASE_URL}/#{type}.json?key=#{API_KEY}&q=#{loc}&days=#{@days}"
  end
  def validate_location(loc)

  end

  def validate_num_of_days(num)
    (0..10) === num
  end
end


wf = WeatherForecast.new('las vegas', 0)

pp wf.send_request
