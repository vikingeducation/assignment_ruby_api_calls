require_relative 'weather_forecast'
require 'date'
require 'pry-byebug'
w = WeatherForecast.new

# w.hi_temps
# w.lo_temps
w.today
# w.tomorrow
# w.is_raining
binding.pry
w.five_day
