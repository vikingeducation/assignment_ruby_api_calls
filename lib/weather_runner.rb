require_relative 'day'
require_relative 'weather_forecast'


weather = WeatherForecast.new("New York", 16)
pp weather.forecast
pp weather.hi_temps
pp weather.today
pp weather.tomorrow
pp weather.rainy_days
pp weather.windiest_day
pp weather.absolute_worst_day