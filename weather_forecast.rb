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
    dates = get_dates
    hi_temps = get_values('maxtemp_f')
    lo_temps = get_values('mintemp_f')
    precip   = get_values('totalprecip_in')
    conditions = get_conditions
    winds = get_values('maxwind_mph')
    @formatted_location = get_location
    @stats = {dates: dates, hi_temps: hi_temps, lo_temps: lo_temps,
      precip: precip, conditions: conditions, winds: winds}
  end

  def render(stats)
    puts "*******************"
    puts "#{@days} Day Weather Forecast for #{@formatted_location}".center(@days * 14) if stats[:dates].length > 1
    stats.each do |stat, values|
      row = stat.to_s.rjust(10)
      values.each do |value|
        row  << " #{value.to_s.center(10)} "
      end
      puts row
    end
    puts "*******************"
  end

  def today
    today = {}
    @stats.each do |k,v|
      today[k] = [v[0]]
    end
    puts "Today's Forecast".center(14)
    render(today)
  end

  def tomorrow
    tomorrow = {}
    @stats.each do |k,v|
      tomorrow[k] = [v[1]]
    end
    puts "Tomorrow's Forecast".center(14)
    render(tomorrow)
  end

  private

  def get_response
    response = HTTParty.get(build_url).body
    @response = JSON.parse(response)
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

  def get_values(value)
    values = []
    @days.times do |day|
      values << @response['forecast']['forecastday'][day]['day'][value]
    end
    values
  end

 def get_conditions
   conditions = []
   @days.times do |day|
     conditions << @response['forecast']['forecastday'][day]['day']['condition']['text']
   end
   conditions
 end


  def get_dates
    dates = []
    @days.times do |day|
      dates << @response['forecast']['forecastday'][day]['date']
    end
    dates
  end

  def get_location
    "#{@response['location']['name']}, #{@response['location']['region']}"
  end

end


wf = WeatherForecast.new('berkeley', 5)
today = wf.today
tomorrow = wf.tomorrow

