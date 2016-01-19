require 'httparty'
require 'pp'

class WeatherForecast

  include HTTParty

  base_uri 'http://api.openweathermap.org/data'

  def initialize(location = "reno,us", days = 5)
     @options = { :query => {:q => location, :cnt => days, :APPID => ENV["APPID"]}}
     daily_forecast
     three_hourly_forecast
  end

  def three_hourly_forecast
    @hourly_forecast = self.class.get("/2.5/forecast/?",@options)
  end

  def daily_forecast
    @daily_forecast = self.class.get("/2.5/forecast/daily?q=",@options)
  end

  def hi_temps
    temp_hash = {}
    (@daily_forecast['list']).each do |day|
      date = day['dt']
      hi_temp = day['temp']['max']
      temp_hash[date] = hi_temp
    end
    temp_hash
  end

  def lo_temps
    temp_hash = {}
    (@daily_forecast['list']).each do |day|
      date = day['dt']
      hi_temp = day['temp']['min']
      temp_hash[date] = hi_temp
    end
    temp_hash
  end

  def convert_date(seconds)
    Date.strptime(seconds.to_s, '%s')
  end

  def today
    day = @daily_forecast['list'][0]
    date = day['dt']
    low = day['temp']['min']
    high = day['temp']['max']
    description = day['weather'][0]['description']

    print "Today's date is #{convert_date(date)}. The low is #{(low-273.16).round(3)} Celsius and the high is #{(high-273.16).round(3)} Celsius. Expect #{description}."
  end

  def tomorrow

  end

end

forecast = WeatherForecast.new
forecast.today