# ruby_api_calls
Simple Ruby API Call Assignment

David Watts

Instructions:

create a new object of class Forecast and specify location and # of days
e.g., forecast = Forecast.new("city, ST", <# of days out (1-16>))

pull the data from the server using get_weather method:
e.g., forecast.get_weather

use any of the following methods to get a nice display of weather info:

  today (displays weather info for today, including max and min temp, wind speed)

  tomorrow (tomorrows...)

  all (for each date in data range)

  display(int) (displays info for that one day <int> days out)

  rain? (displays dates in the range of the data that expect rain)
