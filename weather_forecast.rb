require 'pry'
require 'uri'
require 'httparty'
require 'prettyprint'
# http://api.apixu.com/v1/forecast.json?key=fe0fa84dda2a49f28ce160812162007&q=Paris
class WeatherForecast
  BASE_URL = 'http://api.apixu.com/v1/forecast.json?'
  API_KEY = ENV['APIX_API_KEY']

  def initialize(loc, days=1)
    @loc = loc
    @days = days

    validate_location
    validate_num_of_days

    render(get(get_response))
  end

  def get(response)
    dates = get_dates(response)
    hi_temps = get_hi_temps(response)
    lo_temps = get_lo_temps(response)
    precip   = get_precip(response)
    conditions = get_conditions(response)
    winds = get_max_winds(response)
    @formatted_location = get_location(response)
    @stats = {dates: dates, hi_temps: hi_temps, lo_temps: lo_temps,
      precip: precip, conditions: conditions, winds: winds}
  end

  def render(stats)
    puts "#{@days} Day Weather Forecast for #{@formatted_location}".center(50)
    stats.each do |stat, values|
      row = stat.to_s.rjust(10)
      values.each do |value|
        row  << " #{value.to_s.center(10)} "
      end
      puts row
    end
  end

  def today
    today = {}
    @stats.each do |k,v|
      today[k] = v[0]
    end
    today
  end

  def tomorrow
    tomorrow = {}
    @stats.each do |k,v|
      tomorrow[k] = v[1]
    end

    tomorrow
  end

  private

  def get_response
    response = HTTParty.get(build_url).body
    response = JSON.parse(response)
  end

  def build_url
    loc = URI.encode(@loc)
    "#{BASE_URL}key=#{API_KEY}&q=#{loc}&days=#{@days}"
  end

  def validate_location
    raise "Choose valid location" if get_response['error']
  end

  def validate_num_of_days
   raise "Choose number of days between 0 and 10" unless (0..10) === @days
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

  def get_precip(response)
   precips = []
   @days.times do |day|
     precips << response['forecast']['forecastday'][day]['day']['totalprecip_in']
   end
   precips
  end

 def get_conditions(response)
   conditions = []
   @days.times do |day|
     conditions << response['forecast']['forecastday'][day]['day']['condition']['text']
   end
   conditions
 end

 def get_max_winds(response)
   winds = []
   @days.times do |day|
     winds << response['forecast']['forecastday'][day]['day']['maxwind_mph']
   end
   winds
 end

  def get_dates(response)
    dates = []
    @days.times do |day|
      dates << response['forecast']['forecastday'][day]['date']
    end
    dates
  end

  def get_location(response)
    "#{response['location']['name']}, #{response['location']['region']}"
  end

end


wf = WeatherForecast.new('boise', 5)


