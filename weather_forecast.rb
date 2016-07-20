require 'pry'
require 'uri'
require 'httparty'
require 'prettyprint'
# http://api.apixu.com/v1/forecast.json?key=fe0fa84dda2a49f28ce160812162007&q=Paris
class WeatherForecast
  BASE_URL = 'http://api.apixu.com/v1/forecast.json?'
  API_KEY = ENV['APIX_API_KEY']

  def initialize(loc, days=1)
    validate_location(loc)
    validate_num_of_days(days)
    @loc = loc
    @days = days
  end

  def get
    response = HTTParty.get(build_url).body
    response = JSON.parse(response)
    hi_temps = get_hi_temps(response)
    lo_temps = get_lo_temps(response)
    # precipitation = get_precip(response)
    @stats = [hi, lo, prep]
  end

  private

  def build_url
    loc = URI.encode(@loc)
    "#{BASE_URL}key=#{API_KEY}&q=#{loc}&days=#{@days}"
  end
  def validate_location(loc)

  end

  def validate_num_of_days(num)
     raise "Choose number of days between 0 and 10" unless (0..10) === num
  end

  def get_hi_temps(response)
    hi_temps = []
    @days.times do |day|
      hi_temps << response['forecast']['forecastday'][day]['day']['maxtemp_f']
    end
    hi_temps
  end

   def get_lo_temps(response)
    lo_temps = []
    @days.times do |day|
      lo_temps << response['forecast']['forecastday'][day]['day']['mintemp_f']
    end
    lo_temps
  end

  def today
    today = []
    @stats.each do |stat|
      today << stat[0]
    end
    today
  end

  def tomorrow
    tomorrow = []
    @stats.each do |stat|
      tomorrow << stat[1]
    end
    tomorrow
  end
end


wf = WeatherForecast.new('las vegas', 11)

pp wf.get
