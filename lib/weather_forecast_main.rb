require_relative 'weather_forecast_api'

# Instructions:

# 1) Run this file as-is 'ruby weather_forecast_main'
# This will hit the api and store the results locally
# You can only do this once per 10 minutes
forecast = WeatherForecast.new(zip: 70115, days: 5)


# 2) Now that you've pinged the api, comment out this line
# so that you don't do it again.
forecast.send_request


# 3) Once line 7 is commented out, uncomment each of these
# methods to see the results

# forecast.high_temps
# forecast.low_temps
# forecast.today
# forecast.tomorrow