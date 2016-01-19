require 'httparty'


class WeatherForecast

  include HTTParty

  base_uri 'http://api.openweathermap.org/data'

  def initialize(location = "reno,us", days = 5)
     @options = { :query => {:q => location, :cnt => days, :APPID => ENV["weather_key"]}}
  end


  def three_hourly_forecast
    self.class.get("/2.5/forecast/?",@options)
  end

  def daily_forecast
    self.class.get("/2.5/forecast/daily?q=",@options)
  end

end

# weather_guess = WeatherForecast.new
 @daily_forcast = weather_guess.daily_forecast
# hourly_forcast = weather_guess.three_hourly_forecast